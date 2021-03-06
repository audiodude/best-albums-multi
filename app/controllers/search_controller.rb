class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def parse_date(date)
    year, month, day = date.split('T')[0].split('-')
    if month == '00'
      return year
    end
    if day == '00'
      return "#{year}-#{month}"
    else
      return "#{year}-#{month}-#{day}"
    end
  end

  def albums
    query = request.query_parameters['q']
    client = HTTPClient.new default_header: {'User-Agent' => 'BestAlbumsBot 0.1.0/Audiodude <audiodude@gmail.com>'}

    content = client.get_content(
      'https://www.wikidata.org/w/api.php',
      action: 'wbsearchentities',
      search: query, language: 'en', format: 'json'
    )
    results = JSON.parse(content)
    raise StandardError, 'Error from external endpoint' if results['success'] != 1

    ids = results['search'].map { |r| "wd:#{r['id']}" }.join(' ')

    if ids.empty?
      render json: []
      return
    end

    sparql = <<-SPARQL
      SELECT ?a ?aLabel ?r ?rLabel ?mbid ?spid ?date WHERE {
        VALUES ?a { #{ids} }
        { ?a wdt:P31 wd:Q208569 } UNION
        { ?a wdt:P31 wd:Q482994 } UNION
        { ?a wdt:P31 wd:Q222910 } UNION
        { ?a wdt:P31 wd:Q723849 } UNION
        { ?a wdt:P31 wd:Q4176708 }
        ?a wdt:P175 ?r .
        OPTIONAL {
          ?a wdt:P436 ?mbid .
        }
        OPTIONAL {
          ?a wdt:P2205 ?spid .
        }
        OPTIONAL {
          ?a wdt:P577 ?date
        }
        SERVICE wikibase:label {
          bd:serviceParam wikibase:language "en" .
        }
      }
    SPARQL

    res = client.post('https://query.wikidata.org/sparql', query: sparql, format: 'json')
    data = JSON.parse(res.body)
    albums = {}

    data['results']['bindings'].each do |b|
      id_ = b['a']['value'].split('/')[-1]
      next if albums.key?(id_)

      a = {
        id: id_,
        title: b['aLabel']['value'],
        artist: b['rLabel']['value'],
        date: b['date'] && parse_date(b['date']['value']),
        mbid: b['mbid'] && b['mbid']['value'],
        spid: b['spid'] && b['spid']['value']
      }
      albums[id_] = a
    end

    render json: albums.values
  end
end
