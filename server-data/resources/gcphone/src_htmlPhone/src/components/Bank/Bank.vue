<template>
  <div class="screen" @click="onBackspace">
    <div class='elements'>
      <img class="logo_maze" src="/html/static/img/app_bank/logo_mazebank.jpg">
      <div class="hr"></div>
      <div class='element'>
        <div class="element-content">
          <span>$ {{ bankAmontFormat }}</span>
        </div>
        <div class="button" @click="transferMoney">Перевести</div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data () {
    return {
    }
  },
  computed: {
    ...mapGetters(['bankAmont']),
    bankAmontFormat () {
      return Intl.NumberFormat().format(this.bankAmont)
    }
  },
  methods: {
    onEnter: function () {
      this.transferMoney()
    },
    onBackspace () {
      this.$router.push({ name: 'home' })
    },
    transferMoney () {
      this.$phoneAPI.transferMoney()
    }
  },
  created () {
    this.$bus.$on('keyUpBackspace', this.onBackspace)
    this.$bus.$on('keyUpEnter', this.onEnter)
  },
  beforeDestroy () {
    this.$bus.$off('keyUpBackspace', this.onBackspace)
    this.$bus.$off('keyUpEnter', this.onEnter)
  }
}
</script>

<style scoped>
.screen{
  position: relative;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  padding: 18px;
  background-color: white;
}
.title{
  padding-left: 16px;
  height: 34px;
  line-height: 34px;
  font-weight: 700;
  color: white;
  background-color: rgb(76, 175, 80);
}
.elements{
  display: flex;
  position: relative;
  width: 100%;
  flex-direction: column;
  height: 100%;
  justify-content: center;
}
.hr{
  width: 100;
  height: 4px;
  margin-top: 4px;
  background-color: #EB202D;
}
.logo_maze {
  width: 100%;
  height: auto;
  flex-shrink: 0;
}
.element-content{
  margin-top: 24px;
  display: block;
  height: 40px;
  width: 100%;
  text-align: center;
  font-weight: 700;
  font-size: 24px;
  color: #EB202D;
}
.button {
    width: 100%;
    background: #EB202D;
    color: white;
    padding: 8px;
    text-align: center;
    border-radius: 7px;
}
.button:hover {
    background: rgb(238, 52, 64);
    cursor: pointer;
}
</style>
