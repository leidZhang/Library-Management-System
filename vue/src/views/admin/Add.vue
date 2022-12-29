<template>
  <div style="padding: 10px;">
    <div style="font-size: 40px; font-family: Arial; margin-bottom: 5px">Add New Admin</div>

    <div style="width: 60%">
      <el-form :inline="true" :model="form" :rules="rules" ref="ruleForm">
        <el-form-item label="First Name: " style="margin-left: 2px" prop="fname">
          <el-input v-model="form.fname" placeholder="Enter first name"></el-input>
        </el-form-item>
        <el-form-item label="Middle: " style="margin-left: 2px" prop="minit">
          <el-input v-model="form.minit" placeholder="Enter middle"></el-input>
        </el-form-item>
        <el-form-item label="Last Name: " style="margin-left: 2px" prop="lname">
          <el-input  v-model="form.lname"  placeholder="Enter last name"></el-input>
        </el-form-item>
        <el-form-item label="Email: " style="margin-left: 2px" prop="email">
          <el-input v-model="form.email" placeholder="Enter email"></el-input>
        </el-form-item>
        <el-form-item label="Phone: " style="margin-left: 2px" prop="phone">
          <el-input v-model="form.phone" placeholder="Enter phone number"></el-input>
        </el-form-item>
        <el-form-item label="Username: " style="margin-left: 2px" prop="username">
          <el-input v-model="form.username" placeholder="Enter username"></el-input>
        </el-form-item>
        <el-form-item label="Province/State: " style="margin-left: 2px" prop="province">
          <el-input v-model="form.province" placeholder="Enter province/state"></el-input>
        </el-form-item>
        <el-form-item label="City: " style="margin-left: 2px" prop="city">
          <el-input v-model="form.city" placeholder="Enter city"></el-input>
        </el-form-item>
        <el-form-item label="Street: " style="margin-left: 2px" prop="street">
          <el-input v-model="form.street" placeholder="Enter street"></el-input>
        </el-form-item>
      </el-form>

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
        email:[{ required: true, validator: checkEmail, trigger: 'blur' }],
        phone:[{ required: true, validator: checkPhone, trigger: 'blur' }]
      }
    }
  },

  methods: {
    save() {
      this.$refs['ruleForm'].validate((valid) => {
        if(valid) {
          request.post('admin/save', this.form).then(res => {
            if(res.code === '200') {
              this.$notify.success('Submitted')
              this.$refs['ruleForm'].resetFields()
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