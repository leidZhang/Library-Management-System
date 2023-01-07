<template>
  <div style="padding: 10px;">
    <!-- date range selector -->
    <div>
      <el-select v-model="form.dateRange" placeholder="Select date range" @change="load">
        <el-option
            v-for="item in range"
            :key="item.value"
            :label="item.label"
            :value="item.value">
        </el-option>
      </el-select>
    </div>
    <!-- line chart area -->
    <div style="margin-top: 10px">
      <el-card>
        <div id="lineChart" style="width: 100%; height: 700px"></div>
      </el-card>
    </div>
  </div>
</template>

<script>
import Cookies from "js-cookie";
import Request from "@/utils/request";
import * as echarts from 'echarts';

const option = {
  title: {
    text: 'Line Chart of Borrows and Returns'
  },
  tooltip: {
    trigger: 'axis'
  },
  legend: {
    data: ['Borrow', 'Return']
  },
  grid: {
    left: '3%',
    right: '4%',
    bottom: '3%',
    containLabel: true
  },
  toolbox: {
    feature: {
      saveAsImage: {}
    }
  },
  xAxis: {
    type: 'category',
    boundaryGap: false,
    data: [] // get date form backend
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      name: 'Borrow',
      type: 'line',
      data: [] // get number of borrow records of a day form backend
    },
    {
      name: 'Return',
      type: 'line',
      data: [] // get number of record records of a day form backend
    },
  ]
};

export default {
  data() {
    return {
      admin: Cookies.get('admin') ? JSON.parse(Cookies.get('admin')): {},
      form: { dateRange: 'week' },
      lineBox: null, // echarts container
      range: [{
        value: 'week',
        label: 'Recent week'
      }, {
        value: 'month',
        label: 'Recent 30 days'
      }, {
        value: 'month2',
        label: 'Recent 60 days'
      }, {
        value: 'month3',
        label: 'Recent 90 days'
      }],
    }
  },

  created() {
    Request.get('/admin/' + this.admin.email).then(res => {
      if(res.data !== null) {
        this.admin = res.data
      } else {
        this.$router.push('/login') // jump to /login if res.data == null
      }
    })
  },

  mounted() {
    this.load()
  },

  methods: {
    load() {
      if(!this.lineBox) {
        this.lineBox = echarts.init(document.getElementById('lineChart')) // init lineBox
      }
      Request.get('/lineChart/getLineChart/' + this.form.dateRange).then(res => {
        option.xAxis.data = res.data.date // get date range
        option.series[0].data = res.data.borrows // get borrow data
        option.series[1].data = res.data.reterns // get return data
        this.lineBox.setOption(option) // generate line chart
      })
    },


  }
}
</script>

<style>

</style>