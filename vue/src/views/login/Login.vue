<template>
  <div style="height: 100vh; overflow: hidden">
    <div style="width: 500px; height: 400px; background-color: white; border-radius: 10px; padding: 50px; margin: 150px auto">
      <!-- header -->
      <div style="text-align: center; font-size: 40px; font-weight: bold; font-family: Arial; color: mediumblue">
        Sign in
      </div>
      <!-- form -->
      <div style="margin-top: 22px">
        <el-form>
          <el-form-item prop="email">
            <el-input placeholder="Enter email" prefix-icon="el-icon-user" v-model="admin.email"></el-input>
          </el-form-item>
          <el-form-item prop="password">
            <el-input placeholder="Enter password" prefix-icon="el-icon-lock" v-model="admin.password"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <!-- button -->
      <div>
        <el-button style="width: 100%" type="primary" @click="login">sign in</el-button>
      </div>
      <!-- error message -->
      <div style="margin-top: 5px">
        <span style="color: red">{{ message }}</span>
      </div>
    </div>
  </div>
</template>

<script>


import request from "@/utils/request";

export default {
  name: "login",

  data() {
    return {
      admin: {},
      message: ""
    }
  },

  methods: {
    login() {
      request.post('admin/login', this.admin).then(res => {
        if(res.code === '200') {
          this.$notify.success("sign in successful")
          this.$router.push('/')
        } else {
          this.message = "Wrong email or password"
        }
      })
    }
  }
}
</script>

<style scoped>

</style>