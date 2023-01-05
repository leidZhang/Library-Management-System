<template>
  <div style="padding: 10px;">
    <div style="font-size: 40px; font-family: Arial; margin-bottom: 5px">Edit Borrow</div>
    <div style=" width: 80%">
      <!-- form area -->
      <el-form :inline="true" :model="form" :rules="rules" ref="ruleForm">
        <el-form-item label="ISBN: " style="margin-left: 2px" prop="isbn">
          <el-select v-model="form.isbn" clearable filterable placeholder="Please select" @change="selectBook">
            <el-option
                v-for="item in books"
                :key="item.isbn"
                :label="item.isbn"
                :value="item.isbn">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="Book Name: " style="margin-left: 2px" prop="name">
          <el-input v-model="form.name" placeholder="Enter book's name" disabled></el-input>
        </el-form-item>
        <el-form-item id="credit" label="Credit: " style="margin-left: 2px;" prop="credit">
          <el-input v-model="form.credit" placeholder="Enter credit" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item id="number" label="Number: " style="margin-left: 2px;" prop="number">
          <!-- No book‘s number when entering the edit page since it is not stored in the borrow entity -->
          <el-input v-model="form.number" placeholder=" -- Not Needed -- " disabled></el-input>
        </el-form-item>
        <el-form-item label="Email: " style="margin-left: 2px" prop="email">
          <el-select v-model="form.email" :disabled="true" clearable filterable placeholder="Please select" @change="selectUser">
            <el-option
                v-for="item in users"
                :key="item.email"
                :label="item.email"
                :value="item.email">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="Phone: " style="margin-left: 2px" prop="phone">
          <el-input v-model="form.phone" placeholder="Enter phone number" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="Username: " style="margin-left: 2px" prop="username">
          <el-input v-model="form.username" placeholder="Enter username" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="Credit Left: " style="margin-left: 2px" prop="acredit">
          <el-input v-model="form.acredit" placeholder="Enter credit value" disabled></el-input>
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
      books: [],
      users: [],
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
    // navi by email and isbn
    const email = this.$route.query.email
    const isbn = this.$route.query.isbn
    request.get('/borrow/' + email + '&' +isbn).then(res => {
      this.form = res.data
    })
    // get book list
    request.get('/book/list').then(res => {
      this.books = res.data
    })
    // get user list
    request.get('/user/list').then(res => {
      this.users = res.data
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
    // get data from book
    selectBook() {
      // console.log(this.form.isbn)
      const book = this.books.find(v => v.isbn === this.form.isbn)
      request.get("/book/" + book.isbn).then( res => {
        this.form.name = res.data.name
        this.form.credit = res.data.credit
        this.form.number = res.data.number
        this.$forceUpdate() // force to update, or the input box would not update in time
      })
      }


    },
    // get data from user
    selectUser() {
      const user = this.users.find(v => v.email === this.form.email)
      request.get("/user/" + user.email).then(res => {
        this.form.phone = res.data.phone
        this.form.username = res.data.username
        this.form.acredit = res.data.acredit
        this.$forceUpdate()
      })
    }
}
</script>

<style scoped>

</style>