<template>
  <div id="app">
    <input @input="debounceInput" v-model="queryInput">
    <album v-for="a in albums" :title="a.title" :artist="a.artist" :date="a.date" :key="a.id"></album>
  </div>
</template>

<script>
var debounce = require('debounce');
var Album = require('./album.vue').default;

export default {
  components: {
    Album,
  },
  data: function () {
    return {
      albums: [],
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
      fetch(`/search/albums?q=${this.query}`).then((r) => {
        if (!r.ok) {
          throw new Error('Search endpoint returned: ' + r.statusText);
        }
        return r;
      }).then((r) => r.json())
        .then((data) => {
          this.albums = data
      })
    }
  }
}
</script>

<style scoped>
#app {
  margin-bottom: 1rem;
}
</style>
