<template>
  <div style="padding: 10px;">
    <div style="font-size: 40px; font-family: Arial; margin-bottom: 5px">Add New Book</div>
    <div style="width: 60%">
      <!-- form area -->
      <el-form :inline="true" :model="form" :rules="rules" ref="ruleForm">
        <el-form-item label="ISBN: " style="margin-left: 2px" prop="isbn">
          <el-input v-model="form.isbn" placeholder="Enter isbn"></el-input>
        </el-form-item>
        <el-form-item label="Description: " style="margin-left: 2px;" prop="description">
          <el-input style="width: 500px" type="textarea" v-model="form.description" placeholder="Enter description"></el-input>
        </el-form-item>
        <el-form-item label="Name: " style="margin-left: 2px" prop="name">
          <el-input v-model="form.name" placeholder="Enter name"></el-input>
        </el-form-item>
        <el-form-item label="Category: " style="margin-left: 2px">
          <el-cascader
              :props="{value: 'name', label: 'name'}"
              v-model="form.categories"
              :options="categories"></el-cascader>
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
        <el-form-item id="credit" label="Credit: " style="margin-left: 2px;" prop="credit">
          <el-input v-model="form.credit" placeholder="Enter cover url"></el-input>
        </el-form-item>
        <el-form-item id="cover" label="Cover url: " style="margin-left: 2px;" prop="cover">
          <el-input v-model="form.cover" placeholder="Enter cover url"></el-input>
        </el-form-item>
        <el-form-item id="number" label="Number: " style="margin-left: 2px;" prop="number">
          <el-input v-model="form.number" placeholder="Enter number"></el-input>
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
  name: "Add",
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

    const checkISBN = (rule, value, callback) => {
      if(!value) {
        callback(new Error('Please enter the book\'s ISBN'))
      }
      if (!/^[0-9]{10}$/.test(value)) {
        callback(new Error('Illegal ISBN'));
      }
      callback()
    }

    return {
      form: {},
      categories: [],
      rules: {
        // cannot be empty
        name: [{ required: true, message: "Please enter the book's name", trigger: 'blur' }],
        category: [{ required: true, message: "Please select the book's category", trigger: 'blur' }],
        author: [{ required: true, message: "Please enter the book's author", trigger: 'blur' }],
        publisher: [{ required: true, message: "Please enter the book's publisher", trigger: 'blur' }],
        publish_date: [{ required: true, message: "Please select a date", trigger: 'blur' }],
        //more restrictions
        isbn: [{ required: true,  validator: checkISBN, trigger: 'blur' }],
        number: [{ required: true,  validator: checkNumeric, trigger: 'blur' }],
        credit: [{ required: true,  validator: checkNumeric, trigger: 'blur' }],
      }
    }
  },

  created() {
    request.get('category/tree').then(res => {
      this.categories = res.data
    })
  },

  methods: {
    save() {
      this.$refs['ruleForm'].validate((valid) => {
        if(valid) {
          request.post('book/save', this.form).then(res => {
            if(res.code === '200') {
              this.$notify.success('Submitted')
              this.$refs['ruleForm'].resetFields()
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