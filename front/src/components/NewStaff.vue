<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-10">
        <h1>新员工账号清单</h1>
        <hr><br>
        <alert :message=message v-if="showMessage"></alert>
        <button type="button" class="btn btn-success btn-sm" v-b-modal.book-modal>添加员工</button>
        <br><br>
        <table class="table table-hover">
          <thead>
            <tr>
              <th scope="col">中文名称</th>
              <th scope="col">英文名称</th>
              <th scope="col">手机号</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(book, index) in books" :key="index">
              <td>{{ book.name }}</td>
              <td>{{ book.nick }}</td>
              <td>{{ book.tel }}</td>
              <td>
                <div class="btn-group" role="group">
                  <button
                          type="button"
                          class="btn btn-warning btn-sm"
                          v-b-modal.book-update-modal
                          @click="editBook(book)">
                      Update
                  </button>
                  <button
                          type="button"
                          class="btn btn-danger btn-sm"
                          @click="onDeleteBook(book)">
                      Delete
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <b-modal ref="addBookModal"
            id="book-modal"
            title="添加员工"
            hide-footer>
      <b-form @submit="onSubmit" @reset="onReset" class="w-100">
      <b-form-group id="form-title-group"
                    label="中文名称:"
                    label-for="form-title-input">
          <b-form-input id="form-title-input"
                        type="text"
                        v-model="addBookForm.name"
                        required
                        placeholder="Enter name">
          </b-form-input>
        </b-form-group>
        <b-form-group id="form-author-group"
                      label="英文名称:"
                      label-for="form-author-input">
            <b-form-input id="form-author-input"
                          type="text"
                          v-model="addBookForm.nick"
                          required
                          placeholder="Enter author">
            </b-form-input>
          </b-form-group>
        <b-form-group id="form-author-group"
                      label="手机号:"
                      label-for="form-author-input">
            <b-form-input id="form-author-input"
                          type="text"
                          v-model="addBookForm.tel"
                          required
                          placeholder="Enter author">
            </b-form-input>
          </b-form-group>

        <b-button-group>
          <b-button type="submit" variant="primary">Submit</b-button>
          <b-button type="reset" variant="danger">Reset</b-button>
        </b-button-group>
      </b-form>
    </b-modal>
    <b-modal ref="editBookModal"
            id="book-update-modal"
            title="Update"
            hide-footer>
      <b-form @submit="onSubmitUpdate" @reset="onResetUpdate" class="w-100">
      <b-form-group id="form-title-edit-group"
                    label="Title:"
                    label-for="form-title-edit-input">
          <b-form-input id="form-title-edit-input"
                        type="text"
                        v-model="editForm.name"
                        required
                        placeholder="Enter title">
          </b-form-input>
        </b-form-group>
        <b-form-group id="form-author-edit-group"
                      label="Author:"
                      label-for="form-author-edit-input">
            <b-form-input id="form-author-edit-input"
                          type="text"
                          v-model="editForm.nick"
                          required
                          placeholder="Enter author">
            </b-form-input>
          </b-form-group>
        <b-form-group id="form-author-edit-group"
                      label="tel:"
                      label-for="form-author-edit-input">
            <b-form-input id="form-author-edit-input"
                          type="text"
                          v-model="editForm.tel"
                          required
                          placeholder="Enter tel">
            </b-form-input>
          </b-form-group>
        <b-button-group>
          <b-button type="submit" variant="primary">Update</b-button>
          <b-button type="reset" variant="danger">Cancel</b-button>
        </b-button-group>
      </b-form>
    </b-modal>
  </div>
</template>

<script>
import axios from 'axios';
import Alert from './Alert.vue';

export default {
  data() {
    return {
      books: [],
      addBookForm: {
        name: '',
        nick: '',
        tel: '',
      },
      message: '',
      showMessage: false,
      editForm: {
        name: '',
        nick: '',
        tel: '',
      },
    };
  },
  components: {
    alert: Alert,
  },
  methods: {
    getBooks() {
      const path = 'http://localhost:5000/newstaff';
      axios.get(path)
        .then((res) => {
          this.books = res.data.books;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
        });
    },
    addBook(payload) {
      const path = 'http://localhost:5000/newstaff';
      axios.post(path, payload)
        .then(() => {
          this.getBooks();
          this.message = '添加成功!';
          this.showMessage = true;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.log(error);
          this.getBooks();
        });
    },
    initForm() {
      this.addBookForm.name = '';
      this.addBookForm.nick = '';
      this.addBookForm.tel = '';
      this.editForm.name = '';
      this.editForm.nick = '';
      this.editForm.tel = '';
    },
    onSubmit(evt) {
      evt.preventDefault();
      this.$refs.addBookModal.hide();
      const payload = {
        name: this.addBookForm.name,
        nick: this.addBookForm.nick,
        tel: this.addBookForm.tel,
      };
      this.addBook(payload);
      this.initForm();
    },
    onReset(evt) {
      evt.preventDefault();
      this.$refs.addBookModal.hide();
      this.initForm();
    },
    editBook(book) {
      this.editForm = book;
    },
    onSubmitUpdate(evt) {
      evt.preventDefault();
      this.$refs.editBookModal.hide();
      const payload = {
        name: this.editForm.name,
        nick: this.editForm.nick,
        tel: this.editForm.tel,
      };
      this.updateBook(payload, this.editForm.tel);
    },
    updateBook(payload, tel) {
      const path = `http://localhost:5000/newstaff/${tel}`;
      axios.put(path, payload)
        .then(() => {
          this.getBooks();
          this.message = 'Book updated!';
          this.showMessage = true;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
          this.getBooks();
        });
    },
    onResetUpdate(evt) {
      evt.preventDefault();
      this.$refs.editBookModal.hide();
      this.initForm();
      this.getBooks(); // why?
    },
    removeBook(tel) {
      const path = `http://localhost:5000/newstaff/${tel}`;
      axios.delete(path)
        .then(() => {
          this.getBooks();
          this.message = '删除成功!';
          this.showMessage = true;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
          this.getBooks();
        });
    },
    onDeleteBook(book) {
      this.removeBook(book.tel);
    },
  },
  created() {
    this.getBooks();
  },
};
</script>
