<template>
  <div>
    <!-- search area -->
    <div style="margin-bottom: 2px; margin-top: 2px">
      <el-input v-model="params.fname" placeholder="Enter user's First name" style="width: 200px; margin-left: 2px"></el-input>
      <el-input v-model="params.uid" placeholder="Enter user's id" style="width: 200px; margin-left: 2px"></el-input>
      <el-button type="primary" style="margin-left: 2px; height: 40px" icon="el-icon-search" @click="load">Search</el-button>
      <el-button type="warning" style="margin-left: 2px; height: 40px" icon="el-icon-refresh-right" @click="reset">Reset</el-button>
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
        <el-table-column prop="email" label="Email" width="180"></el-table-column>
        <el-table-column prop="username" label="User Name" width="100"></el-table-column>
        <el-table-column prop="phone" label="Phone" width="100"></el-table-column>
        <el-table-column prop="province" label="Province/State" width="100"></el-table-column>
        <el-table-column prop="city" label="City" width="100"></el-table-column>
        <el-table-column prop="street" label="Street" width="150"></el-table-column>
        <el-table-column prop="ctime" label="Create Date" width="120"></el-table-column>
        <el-table-column prop="utime" label="Update Date" width="120"></el-table-column>
        <el-table-column label="Operation"></el-table-column>
      </el-table>
      <!-- page -->
      <el-pagination
          style="margin-top: 5px;"
          background
          :current-page="params.pageNum"
          :page-size="params.pageSize"
          @current-change="changePageNum"
          layout="prev, pager, next"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  name: "List",

  data() {
    return {
      tableData: [],
      total: 0,
      params: {
        pageNum: 1,
        pageSize: 10,
        fname: '',
        uid: '',
      }
    }
  },

  created() {
    this.load()
  },

  methods: {
    load() {
      let url = 'http://localhost:9090/user/page'
      let params = this.params

      url = url + '?pageNum=' + params.pageNum
      url = url + '&pageSize=' + params.pageSize
      url = url + '&fname=' + params.fname
      url = url + '&uid=' + params.uid

      // console.log(url)
      fetch(url).then(res => res.json()).then(res => {
        // console.log(res.data)
        if(res.code === '200') {
          this.tableData = res.data.list
          this.total = res.data.total
        }
      })
    },

    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 10,
        fname: '',
        uid: '',
      }
      this.load()
    },

    changePageNum(pageNum) {
      this.params.pageNum = pageNum
      this.load()
    }
  }

}
</script>

<style scoped>

</style>