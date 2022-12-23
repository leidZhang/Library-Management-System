import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/home/HomeView.vue'
import Layout from "@/views/Layout";

Vue.use(VueRouter)

const routes = [
    // ===== layout =====
  {
    path: '/',
    name: 'layout',
    component: Layout,
    children: [
      // ===== homepage =====
      {
        path: '/home',
        name: 'home',
        component: () => import('@/views/home/HomeView')
      },
      // ===== user =====
      {
        path: '/userList',
        name: 'userList',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '@/views/user/List')
      }
    ]
  },

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
