<template>
  <div style="padding: 10px;">
    <div style="font-size: 40px; font-family: Arial; margin-bottom: 5px">Edit Borrow</div>
    <div style=" width: 60%">
      <!-- form area -->
      <el-form :inline="true" :model="form" :rules="rules" ref="ruleForm">
        <el-form-item label="ISBN: " style="margin-left: 2px" prop="isbn">
          <el-input v-model="form.isbn" placeholder="Enter isbn"></el-input>
        </el-form-item>
        <el-form-item label="Book Name: " style="margin-left: 2px" prop="name">
          <el-input v-model="form.name" placeholder="Enter book's name"></el-input>
        </el-form-item>
        <el-form-item id="credit" label="Credit: " style="margin-left: 2px;" prop="credit">
          <el-input v-model="form.credit" placeholder="Enter cover url" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="Email: " style="margin-left: 2px" prop="email">
          <el-input v-model="form.email" placeholder="Enter email" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="Phone: " style="margin-left: 2px" prop="phone">
          <el-input v-model="form.phone" placeholder="Enter phone number" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="Username: " style="margin-left: 2px" prop="username">
          <el-input v-model="form.username" placeholder="Enter username" :disabled="true"></el-input>
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
    const checkISBN = (rule, value, callback) => {
      if(!value) {
        callback(new Error('Please enter the book\'s ISBN'))
      }
      if (!/^[0-9]{10}$/.test(value)) {
        callback(new Error('Illegal ISBN'));
      }
      callback()
    }

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
      // rules to check the input values
      rules: {
        username: [{ required: true, message: 'Please enter the username', trigger: 'blur' }],
        name: [{ required: true, message: "Please enter the book's name", trigger: 'blur' }],
        credit: [{ required: true, message: "Please enter the book's credit", trigger: 'blur' }],
        // more restrictions
        email:[{ required: true, validator: checkEmail, trigger: 'blur' }],
        phone:[{ required: true, validator: checkPhone, trigger: 'blur' }],
        isbn: [{ required: true,  validator: checkISBN, trigger: 'blur' }],
      }
    }
  },

  created() {
    const email = this.$route.query.email
    const isbn = this.$route.query.isbn
    request.get('/borrow/' + email + '&' +isbn).then(res => {
      this.form = res.data
    })
  },

  methods: {
    save() {
      this.$refs['ruleForm'].validate((valid) => {
        if(valid) {
          request.put('borrow/update', this.form).then(res => {
            if(res.code === '200') {
              this.$notify.success('Updated')
              this.$router.push("/BorrowList")
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