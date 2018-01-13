<template>
  <div class="tournament">
    <h1>{{ tournament.game_name }}</h1>
    <h2>AWAITING SCORES</h2>
      <div v-for="match in tournament.matches.filter(elem => elem.underway_at !== null && elem.state == 'open')">
        {{ match.player1 }}, {{ match.player2 }}
      </div>
      <h2>READY TO PLAY</h2>
      <div v-for="match in this.readyToPlay(tournament)">
        <span v-if="match.underway_at != null"> Underway </span>
        {{ match.player1 }}, {{ match.player2 }}
      </div>
      <h2>COMING UP</h2>
      <div v-for="match in tournament.matches.filter(elem => elem.state == 'pending')">
        <span v-if="match.underway_at != null"> Underway </span>
        {{ match.player1 }}, {{ match.player2 }}
      </div>
      <h2>COMPLETE</h2>
      <table align="center" v-for="match in tournament.matches.filter(elem => elem.state == 'complete').reverse()">
        <tr>
          <td>{{ match.player1 }}</td>
          <td class="score">{{ match.scores_csv }}</td>
          <td>{{ match.player2 }}</td>
        </tr>
      </table>
  </div>
</template>

<script>
const request = require('superagent');
const deepEqual = require('deep-equal');

export default {
  name: 'HelloWorld',
  props: ['name', 'host'],
  data() {
    return {
      tournament: {},
      // name: 'ww124340',
      audio: new Audio('/static/letsgo_1.mp3'),
    };
  },
  methods: {
    playAudio() {
      this.audio.play();
    },
    readyToPlay(tournament) {
      return tournament.matches.filter(elem => elem.underway_at === null && elem.state === 'open');
    },
    runningIdentifier(tournament) {
      return this.readyToPlay(tournament).map(match => match.identifier);
    },
    findPlayer: (participants, id) => participants.find(elem => elem.participant.id === id),
    buildTournament(tournament) {
      const newTournament = tournament;
      newTournament.matches = tournament.matches.map((match) => {
        const update = match.match;
        const player1 = tournament.participants.find(elem =>
          elem.participant.id === match.match.player1_id);
        if (player1 !== undefined) {
          update.player1 = player1.participant.name;
        }
        const player2 = tournament.participants.find(elem =>
          elem.participant.id === match.match.player2_id);
        if (player2 !== undefined) {
          update.player2 = player2.participant.name;
        }
        if (match.match.winner_id !== null) {
          const winner =
            tournament.participants.find(elem => match.match.winner_id === elem.participant.id);
          update.winner = winner.participant.name;
        }
        return update;
      });

      return newTournament;
    },
    updateTournament() {
      request.get(`http://localhost/tournaments/${this.name}.json?include_participants=1&include_matches=1`)
        .then((data) => {
          const newtournament = this.buildTournament(data.body.tournament);
          if (deepEqual(this.runningIdentifier(newtournament),
              this.runningIdentifier(this.tournament))) {
            console.log('same');
          } else {
            console.log('different');
            this.playAudio();
          }
          this.tournament = newtournament;
        });
    },
  },
  mounted() {
    request.get(`http://${this.host}/tournaments/${this.name}.json?include_participants=1&include_matches=1`)
      .then((data) => {
        this.tournament = this.buildTournament(data.body.tournament);
      });
    setInterval(this.updateTournament, 30000);
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.tournament {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  background-color: #444444;
  color: #FFF;
  margin: 40px;
}
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
tr {
  display: flex;
  justify-content: center;
}
td {
  width: 150px;
}
</style>
