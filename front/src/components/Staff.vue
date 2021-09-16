/* eslint-disable */
<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-10">
        <h1>Staff</h1>
        <hr><br><br>
        <br><br>
        <table class="table table-hover">
          <thead>
            <tr>
              <th scope="col">Name</th>
              <th scope="col">Nick</th>
              <th scope="col">Tel</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(staff, index) in staff" :key="index">
              <td>{{ staff.name }}</td>
              <td>{{ staff.nick }}</td>
              <td>{{ staff.tel }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
import axios from 'axios';

export default {
  data() {
    return {
      staff: [],
      };
  },
  methods: {
    getStaff() {
      const path = 'http://localhost:5000/getstaff';
      axios.get(path)
        .then((res) => {
          this.staff = res.data.staff;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
        });
    },
  },
  created() {
    this.getStaff();
  },
};
</script>
