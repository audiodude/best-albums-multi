import bz2
import json
import sys

filename = sys.argv[1]


def get_data(prop, value_name, default=None):
  datavalue = prop.get('mainsnak', {}).get('datavalue', {})
  if value_name is None:
    return datavalue.get('value', default)
  return datavalue.get('value', {}).get(value_name, default)


with bz2.open(filename, "rt") as bzinput:
  lines = []
  for i, line in enumerate(bzinput):
    if i == 0:
      continue

    if 'Q482994' in line:
      out = {}
      found_album = False

      data = json.loads(line[:-2])
      out['id'] = data['id']

      claims = data.get('claims')
      if claims is None:
        continue
      instances = claims.get('P31', [])
      if not instances:
        continue
      for instance in instances:
        instance_id = get_data(instance, 'id')
        if instance_id is not None and instance_id == 'Q482994':
          found_album = True
          titles = claims.get('P1476', [])
          for title in titles:
            title_text = get_data(title, 'text', '')
            if title_text:
              out['name'] = title_text
              break
          else:
            name = data.get('labels', {}).get('en', {}).get('value')
            if name:
              out['name'] = name
            else:
              found_album = False

          publication_dates = claims.get('P577', [])
          for publication_date in publication_dates:
            date = get_data(publication_date, 'time')
            if date:
              out['date'] = date
              break

          mbids = claims.get('P436', [])
          for mbid in mbids:
            mbid_text = get_data(mbid, None)
            if mbid_text:
              out['mbid'] = mbid_text
              break

          spids = claims.get('P2205', [])
          for spid in spids:
            spid_text = get_data(spid, None)
            if spid_text:
              out['spotify_id'] = spid_text
              break

      if found_album:
        print(out)