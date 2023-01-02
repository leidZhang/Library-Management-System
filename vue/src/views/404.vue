<template>
  <div style="text-align: center;">
    <div style="margin-top: 150px; font-size: 60px">Error 404</div>
    <div style="font-size: 50px">Page not found</div>
    <div><el-button type="text" style="font-size: 20px" @click="$router.push('/')">Return to homepage</el-button></div>
  </div>
</template>

<script>
export default {
  name: "404"
}
</script>

<style scoped>

</style>