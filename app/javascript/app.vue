<template>
  <div id="app">
    <input @input="debounceInput" v-model="queryInput">
  </div>
</template>

<script>
var debounce = require('debounce');

export default {
  data: function () {
    return {
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
          console.log(data);
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
