<template>
  <div>
    <div class="hello">
      <Tournament v-on:remove="remove(name)" v-for="name in brackets" host="brackets.superminerbattle.farm" v-bind:name="name"></Tournament>
    </div>
    <div class="options">
      <input v-model="newBracket"></input><button v-on:click="add(newBracket)">add</button>
    </div>
  </div>
</template>

<script>
import Tournament from '@/components/Tournament';

export default {
  name: 'HelloWorld',
  components: {
    Tournament,
  },
  methods: {
    remove(tournamentname) {
      this.brackets.splice(this.brackets.indexOf(tournamentname), 1);
    },
    add(name) {
      this.brackets.push(name);
    },
  },
  data() {
    return {
      msg: 'Welcome to Your Vue.js App',
      brackets: ['ww124340', 'WWSF4', 'Ww237t7'],
      newBracket: '',
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
.hello {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
}
</style>
