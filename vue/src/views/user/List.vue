<template>
  <div>
    <!-- search area -->
    <div style="margin-bottom: 2px; margin-top: 2px">
      <el-input v-model="params.email" placeholder="Enter user email" style="width: 200px; margin-left: 2px"></el-input>
      <el-input v-model="params.uid" placeholder="Enter user id" style="width: 200px; margin-left: 2px"></el-input>
      <el-button type="primary" style="margin-left: 2px; height: 40px" icon="el-icon-search" @click="load">Search</el-button>
      <el-button type="warning" style="margin-left: 2px; height: 40px" icon="el-icon-refresh-right" @click="reset">Reset</el-button>
    </div>
    <!-- table area -->
    <div>
      <el-table :data="tableData" style="width: 100%" stripe>
        <el-table-column prop="status" label="Status" width="80">
          <template v-slot="scope2">
            <el-switch
                v-model="scope2.row.status"
                active-color="#13ce66"
                inactive-color="#ff4949"
                @change="changeStatus(scope2.row)">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column prop="uid" label="User ID" show-overflow-tooltip width="130"></el-table-column>
        <el-table-column prop="username" label="Username" show-overflow-tooltip width="100"></el-table-column>
        <el-table-column prop="fname" label="First Name" width="100"></el-table-column>
        <el-table-column prop="lname" label="Last Name" width="100"></el-table-column>
        <el-table-column prop="age" label="Age" width="50"></el-table-column>
        <el-table-column prop="email" label="Email" show-overflow-tooltip width="150"></el-table-column>
        <el-table-column prop="phone" label="Phone" width="110"></el-table-column>
        <el-table-column prop="province" label="Province/State" width="95"></el-table-column>
        <el-table-column prop="city" label="City" show-overflow-tooltip width="80"></el-table-column>
        <el-table-column prop="street" label="Street" show-overflow-tooltip width="100"></el-table-column>
        <el-table-column prop="ctime" label="Create Date" width="120"></el-table-column>
        <el-table-column prop="utime" label="Update Date" width="120"></el-table-column>
        <el-table-column prop="acredit" label="Score" width="70"></el-table-column>
        <el-table-column fixed="right" label="Operations" width="265">
          <template v-slot="scope">
            <el-button type="success" @click="chargeOpen(scope.row)">Reharge</el-button>
            <el-button type="primary" style="margin-left: 2px;" @click="$router.push('/editUser?email=' + scope.row.email)">Edit</el-button>
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
      <!-- charge up user account -->
      <el-dialog style="text-align: center" :visible.sync="dialogFormVisible">
        <div style="font-size: 30px; font-family: Arial; font-weight: bold">Charge Up User's Account</div>
        <el-form :model="form" :rules="rules" ref="ruleForm" style="margin-top: 15px; width: 80vh;">
          <el-form-item label="User email: " :label-width="formLabelWidth" prop="name">
            <el-input v-model="form.email" disabled autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="Current credit: " :label-width="formLabelWidth" prop="name">
            <el-input v-model="form.acredit" disabled autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="Charge amount: " :label-width="formLabelWidth" prop="charge">
            <el-input v-model="form.charge" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <!-- buttons -->
        <div slot="footer" class="dialog-footer" style="text-align: center; margin-top: -40px">
          <el-button type="primary" @click="chargeUser">Confirm</el-button>
          <el-button type="warning" @click="cancel">Cancel</el-button>
        </div>
      </el-dialog>
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
    const checkNumeric = (rule, value, callback) => {
      if(!value) {
        callback(new Error('This blank cannot be empty'));
      }
      if(!/^[0-9]*$/.test(value)) {
        callback(new Error('Please enter a numerical value'))
      }
      if(parseInt(value) < 0) {
        callback(new Error('Please enter a number larger than 0'))
      }
      callback()
    }

    return {
      tableData: [],
      total: 0,
      form: {},
      dialogFormVisible: false,
      formLabelWidth: '200px',
      params: {
        pageNum: 1,
        pageSize: 10,
        email: '',
        uid: '',
      },
      rules: {
        charge: [{ required: true,  validator: checkNumeric, trigger: 'blur' }],
      }
    }
  },

  created() {
    this.load()
  },

  methods: {
    load() {
      //let url = this.encapsule()
      // console.log(url)
      // fetch(url).then(res => res.json()).then(res => {
      //   // console.log(res.data)
      //   if(res.code === '200') {
      //     this.tableData = res.data.list
      //     this.total = res.data.total
      //   }
      // })

      request.get('user/page', {
        params: this.params
      }).then(res => {
        if(res.code === '200') {
          this.tableData = res.data.list
          this.total = res.data.total
        }
      })
    },

    del(email) {
      request.delete('user/delete/' + email).then(res => {
            if(res.code === '200') {
              this.$notify.success('Deleted')
              this.load()
            } else {
              this.$notify.error(res.msg)
            }
      })
    },

    //encapsule() {
    //  let url = 'http://localhost:9090/user/page'
    //  let params = this.params
//
    //  url = url + '?pageNum=' + params.pageNum
    //  url = url + '&pageSize=' + params.pageSize
    //  url = url + '&email=' + params.email
    //  url = url + '&uid=' + params.uid
//
    //  // console.log(url)
    //  return url
    //},

    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 10,
        email: '',
        uid: '',
      }
      this.value = ''
      this.load()
    },

    changePageNum(pageNum) {
      this.params.pageNum = pageNum
      this.load()
    },

    chargeOpen(row) {
      this.dialogFormVisible = true
      this.form = row
    },

    cancel() {
      this.dialogFormVisible = false
      this.$refs['ruleForm'].resetFields()
    },

    chargeUser() {
      request.post("/user/charge", this.form).then(res => {
        if(res.code === '200') {
          this.$notify.success('Success')
          this.$refs['ruleForm'].resetFields()
          this.dialogFormVisible = false
          location.reload() // refresh page
        } else {
          this.$notify.error(res.msg)
        }
      })
    },

    changeStatus(row) {
      // console.log(row)
      request.put('user/update', row).then(res => {
        if(res.code === '200') {
          this.$notify.success('Status updated')
          this.load()
        } else {
          this.$notify.error(res.msg)
        }
      })
    },
  }
}
</script>

<style scoped>

</style>