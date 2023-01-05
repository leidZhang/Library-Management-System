<template>
  <div>
    <!-- search area -->
    <div style="margin-bottom: 2px; margin-top: 2px">
      <el-input v-model="params.email" placeholder="Enter user email" style="width: 200px; margin-left: 2px"></el-input>
      <el-input v-model="params.isbn" placeholder="Enter book's isbn" style="width: 200px; margin-left: 2px"></el-input>
      <el-button type="primary" style="margin-left: 2px; height: 40px" icon="el-icon-search" @click="load">Search</el-button>
      <el-button type="warning" style="margin-left: 2px; height: 40px" icon="el-icon-refresh-right" @click="reset">Reset</el-button>
    </div>
    <!-- table area -->
    <div>
      <el-table :data="tableData" style="width: 100%" stripe>
        <el-table-column prop="email" label="Email" show-overflow-tooltip ></el-table-column>
        <el-table-column prop="username" label="User Name" ></el-table-column>
        <el-table-column prop="phone" label="Phone" ></el-table-column>
        <el-table-column prop="isbn" label="ISBN" ></el-table-column>
        <el-table-column prop="name" label="Name" show-overflow-tooltip width="400"></el-table-column>
        <el-table-column prop="credit" label="Credit"></el-table-column>
        <el-table-column prop="cDate" label="Create Date" ></el-table-column>
        <el-table-column fixed="right" label="Operation" >
          <template v-slot="scope">
            <!--<el-button type="primary" disabled @click="$router.push('/editBorrow?email=' + scope.row.email + '&isbn=' + scope.row.isbn)">
              Edit
            </el-button>-->
            <el-popconfirm
                confirm-button-text='Yes'
                cancel-button-text='No'
                title="Are you sure you want to delete this row of data？"
                @confirm="del(scope.row)"
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
        isbn: '',
      },
    }
  },

  created() {
    this.load()
  },

  methods: {
    load() {
      request.get('borrow/page', {
        params: this.params
      }).then(res => {
        if(res.code === '200') {
          this.tableData = res.data.list
          this.total = res.data.total
        }
      })
    },

    del(row) {
      const email = row.email
      const isbn = row.isbn

      request.delete('borrow/delete/' + email + '&' + isbn).then(res => {
        if(res.code === '200') {
          this.$notify.success('Deleted')
          this.load()
        } else {
          this.$notify.error(res.msg)
        }
      })
    },

    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 10,
        email: '',
        isbn: '',
      }
      this.value = ''
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