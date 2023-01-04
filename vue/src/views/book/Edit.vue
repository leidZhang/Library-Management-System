<template>
  <div style="padding: 10px;">
    <div style="font-size: 40px; font-family: Arial; margin-bottom: 5px">Edit Book</div>
    <div style="width: 60%">
      <!-- form area -->
      <el-form :inline="true" :model="form" :rules="rules" ref="ruleForm">
        <el-form-item label="ISBN: " style="margin-left: 2px" prop="isbn">
          <el-input v-model="form.isbn" placeholder="Enter isbn" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="Description: " style="margin-left: 2px;" prop="description">
          <el-input style="width: 500px" type="textarea" v-model="form.description" placeholder="Enter description"></el-input>
        </el-form-item>
        <el-form-item label="Name: " style="margin-left: 2px" prop="name">
          <el-input v-model="form.name" placeholder="Enter name"></el-input>
        </el-form-item>
        <el-form-item label="Category: " style="margin-left: 2px" prop="category">
          <el-input v-model="form.category" placeholder="Enter category"></el-input>
        </el-form-item>
        <el-form-item label="Author: " style="margin-left: 2px" prop="author">
          <el-input v-model="form.author" placeholder="Enter last name"></el-input>
        </el-form-item>
        <el-form-item label="Publisher: " style="margin-left: 2px" prop="publisher">
          <el-input v-model="form.publisher" placeholder="Enter publisher name"></el-input>
        </el-form-item>
        <el-form-item label="Publish Date: " style="margin-left: 2px" prop="publish_date">
          <el-date-picker
              v-model="form.publish_date"
              type="date"
              value-format="yyyy-MM-dd"
              placeholder="Select a date">
          </el-date-picker>
        </el-form-item>
        <el-form-item id="cover" label="Cover url: " style="margin-left: 2px;" prop="cover">
          <el-input v-model="form.cover" placeholder="Enter cover url"></el-input>
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
    return {
      form: {},
      rules: {
        // cannot be empty
        name: [{ required: true, message: "Please enter the book's name", trigger: 'blur' }],
        category: [{ required: true, message: "Please enter the book's category", trigger: 'blur' }],
        author: [{ required: true, message: "Please enter the book's author", trigger: 'blur' }],
        publisher: [{ required: true, message: "Please enter the book's publisher", trigger: 'blur' }],
        publish_date: [{ required: true, message: "Please select a date", trigger: 'blur' }],
      }
    }
  },

  created() {
    const isbn = this.$route.query.isbn
    request.get("/book/" + isbn).then(res => {
      this.form = res.data
    })
  },

  methods: {
    save() {
      this.$refs['ruleForm'].validate((valid) => {
        if(valid) {
          request.put('book/update', this.form).then(res => {
            if(res.code === '200') {
              this.$notify.success('Updated')
              this.$router.push("/BookList")
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