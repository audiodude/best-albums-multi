<template>
  <div class="album">
    <div class="img">
      <img class="info art" :src="getFrontUrl()"/>
    </div>
    <div class="text">
      <span class="info title">{{ title }}</span>
      <span class="info artist">{{ artist }}</span>
      <span class="info date">{{ getYear(date) }}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: ['title', 'date', 'artist', 'mbid', 'spid'],
  methods: {
    getFrontUrl: function() {
      return `https://coverartarchive.org/release-group/${ this.mbid }/front-250`;
    },
    getYear: function(d) {
      return d.split('-')[0];
    },
  }
}
</script>

<style scoped>
  .album {
    align-items: center;
    border: 1px solid #000;
    display: flex;
    max-width: 22%;
    margin: .4rem;
    padding: .4rem;
  }

  @media (max-width: 1200px) {
    .album {
      max-width: 30%;
    }
  }

  .info {
    display: block;
  }

  .art {
    width: 100px;
  }

  .text {
    font-size: 1.2rem;
    line-height: 1.5rem;
    margin-left: .4rem;
  }

  .title {
    font-style: italic;
  }

  .artist {
    font-weight: bold;
  }

  .date {
    font-size: 1rem;
  }
</style>
