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
    max-width: 30%;
    margin: .4rem .8rem .4rem 0;
    padding: .4rem;
  }

  .info {
    display: block;
  }

  .art {
    width: 100px;
  }


  @media (max-width: 1300px) {
    .album {
      max-width: 18%;
    }
  }

  @media (max-width: 1000px) {
    .album {
      max-width: 45%;
    }
    .art {
      width: 80px;
    }
    .text {
      font-size: 1rem;
      line-height: 1.2rem;
      margin-left: .3rem;
    }
    .date {
     font-size: .6rem;
    }
  }

  @media (max-width: 800px) {
    .album {
      max-width: 50%;
    }
    .art {
      width: 60px;
    }
    .text {
      font-size: .8rem;
      line-height: 1.2rem;
      margin-left: .2rem;
    }
    .date {
     font-size: .6rem;
    }
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
