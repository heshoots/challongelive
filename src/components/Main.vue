<template>
  <div class="hello">
    <Tournament host="brackets.superminerbattle.farm" name="ww124340"></Tournament>
    <Tournament host="brackets.superminerbattle.farm" name="WWSF4"></Tournament>
    <Tournament host="brackets.superminerbattle.farm" name="Ww237t7"></Tournament>
  </div>
</template>

<script>
import Tournament from '@/components/Tournament';

export default {
  name: 'HelloWorld',
  components: {
    Tournament,
  },
  data() {
    return {
      msg: 'Welcome to Your Vue.js App',
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
}
</style>
