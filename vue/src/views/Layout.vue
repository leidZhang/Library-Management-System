<template>
  <div>
    <!-- header -->
    <div style="height: 80px; line-height: 80px; background-color: white; margin-bottom: 2px; display: flex">
      <img src="@/assets/logo.png" alt="" style="width: 50px; height: 50px; position: relative; top: 15px; left: 10px">
      <span style="margin-left: 20px; font-size: 40px; font-family: Arial">LIBRARY MANAGEMENT SYSTEM</span>
    </div>

    <!-- side and main -->
    <div style="display: flex">
      <!-- side -->
      <div style="width: 230px; min-height: calc(100vh - 82px); height: 200px; overflow: hidden; margin-right: 2px; background-color: white;">
        <el-menu :default-active="$route.path" :default-opens="['user']" router>
          <el-menu-item index="/home">
            <i class="el-icon-s-data"></i>
            <span style="font-family: Arial; font-size: 15px;">Homepage</span>
          </el-menu-item>

          <el-submenu index="user">
            <template slot="title">
              <i class="el-icon-user"></i>
              <span style="font-family: Arial; font-size: 15px;">User Management</span>
            </template>
            <el-menu-item index="/addUser">Add New User</el-menu-item>
            <el-menu-item index="/userList">User List</el-menu-item>
          </el-submenu>

          <el-submenu index="admin">
            <template slot="title">
              <i class="el-icon-user-solid"></i>
              <span style="font-family: Arial; font-size: 15px;">Admin Management</span>
            </template>
            <el-menu-item index="/addAdmin">Add New Admin</el-menu-item>
            <el-menu-item index="/adminList">Admin List</el-menu-item>
          </el-submenu>

          <el-submenu index="book">
            <template slot="title">
              <i class="el-icon-collection"></i>
              <span style="font-family: Arial; font-size: 15px;">Book Management</span>
            </template>
            <el-menu-item index="/addBook">Add New Book</el-menu-item>
            <el-menu-item index="/bookList">Book List</el-menu-item>
          </el-submenu>
        </el-menu>
      </div>
      <!-- main -->
      <div style="flex: 1; background-color: white">
        <router-view/>
      </div>
    </div>
  </div>

</template>

<script>
export default {
  name: "Layout"
}
</script>

<style scoped>

</style>