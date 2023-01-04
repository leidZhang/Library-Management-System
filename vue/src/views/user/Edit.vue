<template>
  <div style="padding: 10px;">
    <div style="font-size: 40px; font-family: Arial; margin-bottom: 5px">Edit User</div>
    <div style=" width: 60%">
      <!-- form area -->
      <el-form :inline="true" :model="form" :rules="rules" ref="ruleForm">
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
          <el-input v-model="form.email" placeholder="Enter email" :disabled="true"></el-input>
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
          <el-select v-model="form.gender" placeholder="Please select">
            <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
            </el-option>
          </el-select>
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
  name: "Edit",
  data() {
    const checkAge = (rule, value, callback) => {
      if(!value) {
        callback(new Error('Please enter the age'));
      }
      if(!/^[0-9]*$/.test(value)) {
        callback(new Error('Please enter a numerical value'))
      }
      if(parseInt(value) > 130 || parseInt(value) <= 0) {
        callback(new Error('Please enter a reasonable value'))
      }
      callback()
    };

    const checkEmail = (rule, value, callback) => {
      if(!value) {
        callback(new Error('Please enter the email address'))
      }
      if(!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(value)) {
        callback(new Error('Illegal email address'))
      }
      callback()
    };

    const checkPhone = (rule, value, callback) => {
      if(!value) {
        callback(new Error('Please enter the phone number'))
      }
      if (!/^[1,2,3,4,5,6,7,8,9][0-9]{9}$/.test(value)) {
        callback(new Error('Illegal phone number'));
      }
      callback()
    }

    return {
      form: {},

      options: [{
        value: 'Male',
        label: 'Male'
      }, {
        value: 'Female',
        label: 'Female'
      }, {
        value: 'Other',
        label: 'Other'
      }, {
        value: 'Unknown',
        label: 'Prefer not disclose'
      }],

      // rules to check the input values
      rules: {
        minit: [{ required: false}],
        // cannot be empty
        fname: [{ required: true, message: 'Please enter the first name', trigger: 'blur' }],
        lname: [{ required: true, message: 'Please enter the last name', trigger: 'blur' }],
        username: [{ required: true, message: 'Please enter the username', trigger: 'blur' }],
        province: [{ required: true, message: 'Please enter the province/state', trigger: 'blur' }],
        city: [{ required: true, message: 'Please enter the city', trigger: 'blur' }],
        street: [{ required: true, message: 'Please enter the street address', trigger: 'blur' }],
        // more restrictions
        age:[{ required: true, validator: checkAge, trigger: 'blur' }],
        email:[{ required: true, validator: checkEmail, trigger: 'blur' }],
        phone:[{ required: true, validator: checkPhone, trigger: 'blur' }]
      }
    }
  },

  created() {
    const email = this.$route.query.email
    request.get("/user/" + email).then(res => {
      this.form = res.data
    })
  },

  methods: {
    save() {
      this.$refs['ruleForm'].validate((valid) => {
        if(valid) {
          request.put('user/update', this.form).then(res => {
            if(res.code === '200') {
              this.$notify.success('Updated')
              this.$router.push("/userList")
            } else {
              this.$notify.error(res.msg)
            }
          })
        }
      })
    },
  }
}
</script>

<style scoped>

</style>