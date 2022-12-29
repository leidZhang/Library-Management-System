<template>
  <div>
    <!-- search area -->
    <div style="margin-bottom: 2px; margin-top: 2px">
      <el-input v-model="params.email" placeholder="Enter admin email" style="width: 200px; margin-left: 2px"></el-input>
      <el-input v-model="params.username" placeholder="Enter username" style="width: 200px; margin-left: 2px"></el-input>
      <el-button type="primary" style="margin-left: 2px; height: 40px" icon="el-icon-search" @click="load">Search</el-button>
      <el-button type="warning" style="margin-left: 2px; height: 40px" icon="el-icon-refresh-right" @click="reset">Reset</el-button>
    </div>
    <!-- table area -->
    <el-table :data="tableData" stripe>
      <el-table-column prop="username" label="Username"></el-table-column>
      <el-table-column prop="fname" label="First Name"></el-table-column>
      <el-table-column prop="lname" label="Last Name"></el-table-column>
      <el-table-column prop="email" label="Email"></el-table-column>
      <el-table-column prop="province" label="Province/State"></el-table-column>
      <el-table-column prop="city" label="City"></el-table-column>
      <el-table-column prop="street" label="Street"></el-table-column>
      <el-table-column prop="phone" label="Phone"></el-table-column>
      <el-table-column label="Operations">
        <template v-slot="scope">
          <el-button type="primary" @click="$router.push('/editAdmin?email=' + scope.row.email)">Edit</el-button>
          <el-popconfirm
              confirm-button-text='Yes'
              cancel-button-text='No'
              title="Are you sure you want to delete this row of data？"
              @confirm="del(scope.row.email)"
          >
            <el-button style="margin-left: 2px;" slot="reference" type="danger">Delete</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
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
</template>

<script>
import request from "@/utils/request";

export default {
  name: "List",

  data() {
    return {
      tableData: [],
      total: 0,
      params: {
        pageNum: 1,
        pageSize: 10,
        email: '',
        username: '',
      },
    }
  },

  created() {
    this.load()
  },

  methods: {
    load() {
      request.get('admin/page', {
        params: this.params
      }).then(res => {
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
        email: '',
        username: '',
      }
      this.load()
    },

    del(email) {
      request.delete('admin/delete/' + email).then(res => {
        if(res.code === '200') {
          this.$notify.success('Deleted')
          this.load()
        } else {
          this.$notify.error(res.msg)
        }
      })
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