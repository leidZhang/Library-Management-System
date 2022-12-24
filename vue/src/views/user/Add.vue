<template>
  <div style="padding: 10px;">
    <div style="font-size: 40px; font-family: Arial; margin-bottom: 5px">Add New User</div>
    <div style=" width: 60%">
      <!-- form area -->
      <el-form :inline="true" :model="form">
        <el-form-item label="First Name: " style="margin-left: 2px">
          <el-input v-model="form.fname" placeholder="Enter first name"></el-input>
        </el-form-item>
        <el-form-item label="Middle: " style="margin-left: 2px">
          <el-input v-model="form.minit" placeholder="Enter middle"></el-input>
        </el-form-item>
        <el-form-item label="Last Name: " style="margin-left: 2px">
          <el-input v-model="form.lname" placeholder="Enter last name"></el-input>
        </el-form-item>
        <el-form-item label="Email: " style="margin-left: 2px">
          <el-input v-model="form.email" placeholder="Enter email"></el-input>
        </el-form-item>
        <el-form-item label="Phone: " style="margin-left: 2px">
          <el-input v-model="form.phone" placeholder="Enter phone number"></el-input>
        </el-form-item>
        <el-form-item label="Username: " style="margin-left: 2px">
          <el-input v-model="form.username" placeholder="Enter username"></el-input>
        </el-form-item>
        <el-form-item label="Age: " style="margin-left: 2px">
          <el-input v-model="form.age" placeholder="Enter age"></el-input>
        </el-form-item>
        <el-form-item label="Gender: " style="margin-left: 2px">
          <el-input v-model="form.gender" placeholder="Enter gender"></el-input>
        </el-form-item>
        <el-form-item label="Province/State: " style="margin-left: 2px">
          <el-input v-model="form.province" placeholder="Enter province/state"></el-input>
        </el-form-item>
        <el-form-item label="City: " style="margin-left: 2px">
          <el-input v-model="form.city" placeholder="Enter city"></el-input>
        </el-form-item>
        <el-form-item label="Street: " style="margin-left: 2px">
          <el-input v-model="form.street" placeholder="Enter street"></el-input>
        </el-form-item>
      </el-form>
      <!-- button area -->
      <div style="text-align: center">
        <el-button type="primary" style="margin-left: 2px; height: 40px; min-width: 100px" @click="save">Submit</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Add",
  data() {
    return {
      form: {
        fname: '',
        minit: '',
        lname: '',
        email: '',
        phone: '',
        username: '',
        age: '',
        gender: '',
        province: '',
        city: '',
        street:'',
      }
    }
  },

  methods: {
    save() {
      request.post('user/save', this.form).then(res => {
        if(res.code === '200') {
          this.$notify.success('Submitted')
        } else {
          this.$notify.error(res.msg)
        }
      })
      this.reset()
    },

    reset() {
      this.form = {
        name: '',
        minit: '',
        lname: '',
        email: '',
        phone: '',
        username: '',
        age: '',
        gender: '',
        province: '',
        city: '',
        street:'',
      }
    }
  }
}
</script>

<style scoped>

</style>