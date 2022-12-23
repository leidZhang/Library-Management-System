<template>
  <div>
    <!-- search area -->
    <div style="margin-bottom: 2px; margin-top: 2px">
      <el-input v-model="input1" placeholder="Enter user name" style="width: 200px; margin-left: 2px"></el-input>
      <el-input v-model="input2" placeholder="Enter user id" style="width: 200px; margin-left: 2px"></el-input>
      <el-button type="primary" style="margin-left: 2px; height: 40px" icon="el-icon-search">Search</el-button>
    </div>
    <!-- table area -->
    <div>
      <el-table :data="tableData" style="width: 100%" stripe>
        <el-table-column prop="uid" label="User ID" width="100"></el-table-column>
        <el-table-column prop="fname" label="First Name" width="100"></el-table-column>
        <el-table-column prop="minit" label="Middle" width="80"></el-table-column>
        <el-table-column prop="lname" label="Last Name" width="100"></el-table-column>
        <el-table-column prop="gender" label="Gender" width="80"></el-table-column>
        <el-table-column prop="age" label="Age" width="80"></el-table-column>
        <el-table-column prop="email" label="Email" width="150"></el-table-column>
        <el-table-column prop="username" label="User Name" width="100"></el-table-column>
        <el-table-column prop="phone" label="Phone" width="100"></el-table-column>
        <el-table-column prop="province" label="Province/State" width="90"></el-table-column>
        <el-table-column prop="city" label="City" width="80"></el-table-column>
        <el-table-column prop="street" label="Street" width="150"></el-table-column>
        <el-table-column prop="ctime" label="Create Date" width="120"></el-table-column>
        <el-table-column prop="utime" label="Update Date" width="120"></el-table-column>
        <el-table-column label="Operation"></el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
export default {
  name: "List",

  data() {
    return {
      tableData: []
    }
  },

  created() {
    this.load()
  },

  methods: {
    load() {
      fetch('http://localhost:9090/user/list').then(res => res.json()).then(res => {
        console.log(res)
        this.tableData = res
      })
    }
  }

}
</script>

<style scoped>

</style>