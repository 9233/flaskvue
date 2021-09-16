import Vue from 'vue';
import Router from 'vue-router';
import NewStaff from '../components/NewStaff.vue';
import Staff from '../components/Staff.vue';
import Books from '../components/Books.vue';
import Ping from '../components/Ping.vue';

Vue.use(Router);

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'Newstaff',
      component: NewStaff,
    },
    {
      path: '/staff',
      name: 'Staff',
      component: Staff,
    },
    {
      path: '/books',
      name: 'Books',
      component: Books,
    },
    {
      path: '/ping',
      name: 'Ping',
      component: Ping,
    },
  ],
});
