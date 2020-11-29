<template>
  <div id="app">
    <input @input="debounceInput" v-model="queryInput">
    <div v-if="albums.length == 0 && this.query">
      <pulse-loader class="spinner" :loading="loading" :color="'blue'"></pulse-loader>
      <div id="no-results" v-if="!loading">No results!</div>
    </div>
    <div v-else class="album-container">
      <album v-for="a in albums"
        :title="a.title"
        :artist="a.artist"
        :date="a.date"
        :mbid="a.mbid"
        :spid="a.spid"
        :key="a.id"
      ></album>
    </div>
  </div>
</template>

<script>
var debounce = require('debounce');
var Album = require('./album.vue').default;
var PulseLoader = require('vue-spinner/src/PulseLoader.vue').default;

export default {
  components: {
    Album,
    PulseLoader,
  },
  data: function () {
    return {
      albums: [],
      loading: false,
      message: 'Hello Vue!',
      queryInput: '',
      query: '',
    }
  },
  methods: {
    debounceInput: debounce(function (e) {
      this.query = this.queryInput;
    }, 500)
  },
  watch: {
    query: function () {
      this.loading = true;
      fetch(`/search/albums?q=${this.query}`).then((r) => {
        if (!r.ok) {
          throw new Error('Search endpoint returned: ' + r.statusText);
        }
        return r;
      }).then((r) => r.json())
        .then((data) => {
          this.albums = data;
          this.loading = false;
      })
    }
  }
}
</script>

<style scoped>
#app {
  margin-bottom: 1rem;
}

.spinner, #no-results, .album-container {
  margin-top: 1rem;
}

.album-container {
  display: flex;
  flex-wrap: wrap;
}
</style>
