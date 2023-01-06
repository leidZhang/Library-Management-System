<template>
  <div>
    <!-- header -->
    <div style="height: 80px; line-height: 80px; background-color: white; width: 100%; margin-bottom: 2px; display: flex">
      <!-- logo and title -->
      <div style="width: 800px">
        <img src="@/assets/logo.png" alt="" style="width: 50px; height: 50px; position: relative; top: 15px; left: 10px">
        <span style="margin-left: 20px; font-size: 40px; font-family: Arial">LIBRARY MANAGEMENT SYSTEM</span>
      </div>
      <!-- admins' info -->
      <div style="flex: 1; text-align: right; margin-right: 40px">
        <el-dropdown style="cursor: pointer">
          <span class="el-dropdown-link">
            Welcome {{ admin.username }}<i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <!-- dropdown -->
          <el-dropdown-menu slot="dropdown" style="margin-top: -15px; width: 150px; text-align: left">
            <el-dropdown-item><div @click="dialogFormVisible = true">change password</div></el-dropdown-item>
            <el-dropdown-item><div @click="logout">logout</div></el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
        <!-- change password -->
        <el-dialog style="text-align: center" :visible.sync="dialogFormVisible">
          <div style="font-size: 30px; font-family: Arial; font-weight: bold">Change Password</div>
          <el-form :model="form" :rules="rules" ref="ruleForm" style="margin-top: 2px; width: 80vh;">
            <el-form-item label="Original Password: " :label-width="formLabelWidth" prop="password">
              <el-input v-model="form.password" show-password autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="New Password: " :label-width="formLabelWidth" prop="newPassword">
              <el-input v-model="form.newPassword" show-password autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="Comfirm New Password: " :label-width="formLabelWidth" prop="confirmPassword">
              <el-input v-model="form.confirmPassword" show-password autocomplete="off"></el-input>
            </el-form-item>
          </el-form>
          <!-- buttons -->
          <div slot="footer" class="dialog-footer" style="text-align: center; margin-top: -60px">
            <el-button type="primary" @click="changePass">Confirm</el-button>
            <el-button type="warning" @click="cancelChange">Cancel</el-button>
          </div>
        </el-dialog>
      </div>
    </div>
    <!-- side and main -->
    <div style="display: flex">
      <!-- side -->
      <div style="min-width: 230px; min-height: calc(100vh - 82px); height: 200px; overflow: hidden; margin-right: 2px;
      background-color: white;">
        <el-menu :unique-opened="true" :default-active="$route.path" :default-opens="['user']" router>
          <el-menu-item index="/home">
            <i class="el-icon-s-data"></i>
            <span style="font-family: Arial; font-size: 15px;">Homepage</span>
          </el-menu-item>
          <!-- users -->
          <el-submenu index="user">
            <template slot="title">
              <i class="el-icon-user"></i>
              <span style="font-family: Arial; font-size: 15px;">Users</span>
            </template>
            <el-menu-item index="/addUser">New User</el-menu-item>
            <el-menu-item index="/userList">User List</el-menu-item>
          </el-submenu>
          <!-- admins -->
          <el-submenu index="admin">
            <template slot="title">
              <i class="el-icon-user-solid"></i>
              <span style="font-family: Arial; font-size: 15px;">Administrators</span>
            </template>
            <el-menu-item index="/addAdmin">New Admin</el-menu-item>
            <el-menu-item index="/adminList">Admin List</el-menu-item>
          </el-submenu>
          <!-- category -->
          <el-submenu index="category">
            <template slot="title">
              <i class="el-icon-s-fold"></i>
              <span style="font-family: Arial; font-size: 15px;">Categories</span>
            </template>
            <el-menu-item index="/addCategory">New Parent Category</el-menu-item>
            <el-menu-item index="/categoryList">Category List</el-menu-item>
          </el-submenu>
          <!-- book -->
          <el-submenu index="book">
            <template slot="title">
              <i class="el-icon-collection"></i>
              <span style="font-family: Arial; font-size: 15px;">Books</span>
            </template>
            <el-menu-item index="/addBook">Add New Book</el-menu-item>
            <el-menu-item index="/BookList">Book List</el-menu-item>
          </el-submenu>
          <!-- borrow -->
          <el-submenu index="borrow">
            <template slot="title">
              <i class="el-icon-download"></i>
            <span style="font-family: Arial; font-size: 15px;">Book Borrow</span>
          </template>
          <el-menu-item index="/addBorrow">New Borrow Record</el-menu-item>
          <el-menu-item index="/BorrowList">Borrow Records</el-menu-item>
          </el-submenu>
          <!-- return -->
          <el-submenu index="retern">
            <template slot="title">
              <i class="el-icon-upload2"></i>
              <span style="font-family: Arial; font-size: 15px;">Book Return</span>
            </template>
            <el-menu-item index="/ReternList">Return Records</el-menu-item>
          </el-submenu>
        </el-menu>
      </div>
      <!-- main -->
      <div style="flex: 1; background-color: white;">
        <router-view/>
      </div>
    </div>
  </div>

</template>

<script>
import Cookies from "js-cookie";
import request from "@/utils/request";

export default {
  name: "Layout",
  data() {
    const checkConfirm = (rule, value, callback) => {
      if(!value) {
        callback(new Error("Please enter new password again"))
      }
      if(value != this.form.newPassword) {
        callback(new Error("Please enter the correct new password"))
      }
      callback()
    }

    return {
      admin: Cookies.get('admin') ? JSON.parse(Cookies.get('admin')): {},
      dialogFormVisible: false,
      formLabelWidth: '200px',
      form: {},

      rules: {
        password: [{ required: true, message: "Original password cannot be empty", trigger: 'blur' }],
        newPassword: [
          { required: true, message: "New password cannot be empty", trigger: 'blur' },
          { min: 6, max: 30, message: "Password length must be 6-30" }
        ],
        confirmPassword: [
          { required: true, validator: checkConfirm, trigger: 'blur' },
          { min: 6, max: 30, message: "Password length must be 6-30" }
        ]
      }
    }
  },

  methods: {
    logout() {
      // data removal is required
      Cookies.remove('admin')
      this.$router.push('/login')
    },

    cancelChange() {
      this.dialogFormVisible = false
      this.$refs['ruleForm'].resetFields()
    },

    changePass() {
      this.$refs['ruleForm'].validate((valid) => {
        if(valid) {
          this.form.email = this.admin.email // get email
          request.put('admin/changePass', this.form).then(res => {
            if(res.code === '200') {
              this.$notify("Updated")
              this.$refs['ruleForm'].resetFields()
              this.dialogFormVisible = false
              // Cookies.remove('admin')
              // this.$router.push('/login')
            } else {
              this.$notify(res.msg)
            }
          })
        }
      })
    }
  }
}
</script>

<style scoped>

</style>