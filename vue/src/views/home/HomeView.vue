<template>
  <div class="home">
    <span>Hello Administrator</span>
    <div>Username: {{ admin.username }}</div>
    <div>Email: {{ admin.email }}</div>
    <div>Phone number: {{ admin.phone }}</div>
  </div>
</template>

<script>
import Cookies from "js-cookie";
import Request from "@/utils/request";

export default {
  data() {
    return {
      admin: Cookies.get('admin') ? JSON.parse(Cookies.get('admin')): {}
    }
  },

  created() {
    Request.get('/admin/' + this.admin.email).then(res => {
      if(res.data !== null) {
        this.admin = res.data
      } else {
        this.$router.push('/login') // jump to /login if res.data == null
      }
    })
  }
}
</script>

<style>
  .home {
    margin: 10px;
    font-family: Arial;
  }
</style>