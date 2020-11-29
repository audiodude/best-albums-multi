<template>
  <div class="album">
    <span class="title">{{ title }}</span>
    <span class="artist">{{ artist }}</span>
    <span class="date">{{ date }}</span>
  </div>
</template>

<script>
export default {
  props: ['title', 'date', 'artist']
}
</script>

<style scoped>

</style>
