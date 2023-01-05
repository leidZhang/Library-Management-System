<template>
  <div>
    <!-- search area -->
    <div style="margin-bottom: 2px; margin-top: 2px">
      <el-input v-model="params.name" placeholder="Enter book's name" style="width: 200px; margin-left: 2px"></el-input>
      <el-input v-model="params.isbn" placeholder="Enter ISBN" style="width: 200px; margin-left: 2px"></el-input>
      <el-button type="primary" style="margin-left: 2px; height: 40px" icon="el-icon-search" @click="load">Search</el-button>
      <el-button type="warning" style="margin-left: 2px; height: 40px" icon="el-icon-refresh-right" @click="reset">Reset</el-button>
    </div>
    <!-- table area -->
    <div>
      <el-table :data="tableData" style="width: 100%" stripe>
        <el-table-column prop="isbn" label="ISBN" width="90"></el-table-column>
        <el-table-column prop="name" label="Name" show-overflow-tooltip width="120"></el-table-column>
        <el-table-column prop="category" label="Category" width="130"></el-table-column>
        <el-table-column prop="author" label="Author" width="100"></el-table-column>
        <el-table-column prop="publisher" label="Publisher" width="100"></el-table-column>
        <el-table-column prop="publish_date" label="Publish Date" width="120"></el-table-column>
        <el-table-column prop="description" label="Description" show-overflow-tooltip width="300"></el-table-column>
        <el-table-column prop="cDate" label="Create Date" width="110"></el-table-column>
        <el-table-column prop="uDate" label="Update Date" width="110"></el-table-column>
        <el-table-column prop="cover" label="Cover" width="100">
          <template v-slot="scope1">
            <el-image :src="scope1.row.cover" style="width: 50%; height: 50%"></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="credit" label="Credit" width="85"></el-table-column>
        <el-table-column prop="number" label="Number" width="85"></el-table-column>
        <el-table-column fixed="right" label="Operation" width="200">
          <template v-slot="scope">
            <el-button type="primary" @click="$router.push('/editBook?isbn=' + scope.row.isbn)">Edit</el-button>
            <el-popconfirm
                confirm-button-text='Yes'
                cancel-button-text='No'
                title="Are you sure you want to delete this row of data？"
                @confirm="del(scope.row.isbn)"
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
        uid: '',
      },
    }
  },

  created() {
    this.load()
  },

  methods: {
    load() {
      request.get('book/page', {
        params: this.params
      }).then(res => {
        if(res.code === '200') {
          this.tableData = res.data.list
          this.total = res.data.total
        }
      })
    },

    del(isbn) {
      request.delete('book/delete/' + isbn).then(res => {
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
        name: '',
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
.el-tooltip__popper {
  max-width: 300px;
}
</style>