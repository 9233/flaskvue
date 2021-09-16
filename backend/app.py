import uuid
from flask import Flask, jsonify, request
from flask_cors import CORS

import pymysql


conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='Aa123456',
    db='blog',
    charset='utf8'
)




BOOKS = [
    {
        'id': uuid.uuid4().hex,
        'title': 'On the Road',
        'author': 'Jack Kerouac',
        'read': True
    },
    {
        'id': uuid.uuid4().hex,
        'title': 'Harry Potter and the Philosopher\'s Stone',
        'author': 'J. K. Rowling',
        'read': False
    },
    {
        'id': uuid.uuid4().hex,
        'title': 'Green Eggs and Ham',
        'author': 'Dr. Seuss',
        'read': True
    }
]



# configuration
DEBUG = True

# instantiate the app
app = Flask(__name__)
app.config.from_object(__name__)

# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})






@app.route('/newstaff', methods=['GET', 'POST'])
def Newstaff():
    conn.ping(reconnect=True)

    cur = conn.cursor()
    # get annual sales rank
    sql = """select * from blog_staff"""

    cur.execute(sql)
    content = cur.fetchall()

    response_object = {'status': 'success'}

    #print(content)

    if request.method == 'POST':
        post_data = request.get_json()
        #insert into mysql

        print(post_data)

        cn_name = post_data['name']
        en_name = post_data['nick']
        phone_number = post_data['tel']


        sql = """INSERT INTO blog_staff(cn_name,en_name, phone_number) VALUES ('%s','%s', '%s')""" % (cn_name, en_name, phone_number)

        print(sql)

        try:
            # 执行sql语句
            cur.execute(sql)
            # 提交到数据库执行
            conn.commit()

            print("success!")
        except:
            print("error===============")
            # 如果发生错误则回滚
            conn.rollback()


        conn.close()

        response_object['message'] = '添加成功!'

        return jsonify(response_object)

    else:

        Staff=[]

        for i in content:
            #print(i)

            Staff.append(
             {
            'id': i[0],
            'name': i[1],
            'nick': i[2],
            'tel': i[3]
             }
                )

        response_object['books'] = Staff

        cur.close()
        return jsonify(response_object)










def remove_staff(tel):
    conn.ping(reconnect=True)

    cur = conn.cursor()
    #sql = """INSERT INTO blog_staff(cn_name,en_name, phone_number) VALUES ('%s','%s', '%s')""" % (cn_name, en_name, phone_number)
    sql = """ delete from blog_staff where phone_number = '%s'""" % (tel)

    print(sql)

    try:
        # 执行sql语句
        cur.execute(sql)
        # 提交到数据库执行
        conn.commit()

        print("success!")
        return True
    except:
        print("error===============")
        # 如果发生错误则回滚
        conn.rollback()
        return False

    conn.close()

@app.route('/newstaff/<tel>', methods=['PUT', 'DELETE'])
def single_staff(tel):
    conn.ping(reconnect=True)

    cur = conn.cursor()

    print(tel)
    response_object = {'status': 'success'}
    if request.method == 'PUT':
        post_data = request.get_json()

        remove_staff(tel)
        print(post_data)

        cn_name = post_data['name']
        en_name = post_data['nick']
        phone_number = post_data['tel']

        sql = """INSERT INTO blog_staff(cn_name,en_name, phone_number) VALUES ('%s','%s', '%s')""" % (cn_name, en_name, phone_number)

        print(sql)

        try:
            # 执行sql语句
            cur.execute(sql)
            # 提交到数据库执行
            conn.commit()

            print("success!")
        except:
            print("error===============")
            # 如果发生错误则回滚
            conn.rollback()

        conn.close()
        response_object['message'] = '更新成功!'
    if request.method == 'DELETE':
        remove_staff(tel)
        response_object['message'] = '删除成功!'
    return jsonify(response_object)






@app.route('/getstaff', methods=['GET', 'POST'])
def Staff():
    conn.ping(reconnect=True)

    cur = conn.cursor()
    # get annual sales rank
    sql = """select * from blog_staff"""

    cur.execute(sql)
    content = cur.fetchall()

    #print(content)

    response_object = {'status': 'success'}


    if request.method == 'POST':
        post_data = request.get_json()
        #insert into mysql

        print(post_data)


        response_object['message'] = '添加成功!'

        return jsonify(response_object)

    else:

        Staff=[]

        for i in content:
            #print(i)

            Staff.append(
             {
            'id': i[0],
            'name': i[1],
            'nick': i[2],
            'tel': i[3]
             }
                )

        response_object['staff'] = Staff

        cur.close()
        return jsonify(response_object)




# sanity check route
@app.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify('hello vue!')

# @app.route('/staff', methods=['GET', 'POST'])
# def getStaff():
#     response_object = {'status': 'success'}
#     response_object['books'] = BOOKS
#     return jsonify(response_object)





def remove_book(book_id):
    for book in BOOKS:
        if book['id'] == book_id:
            BOOKS.remove(book)
            return True
    return False


@app.route('/books', methods=['GET', 'POST'])
def all_books():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        post_data = request.get_json()
        BOOKS.append({
            'id': uuid.uuid4().hex,
            'title': post_data.get('title'),
            'author': post_data.get('author'),
            'read': post_data.get('read')
        })
        response_object['message'] = 'Book added!'
    else:
        response_object['books'] = BOOKS
    return jsonify(response_object)


@app.route('/books/<book_id>', methods=['PUT', 'DELETE'])
def single_book(book_id):
    response_object = {'status': 'success'}
    if request.method == 'PUT':
        post_data = request.get_json()
        remove_book(book_id)
        BOOKS.append({
            'id': uuid.uuid4().hex,
            'title': post_data.get('title'),
            'author': post_data.get('author'),
            'read': post_data.get('read')
        })
        response_object['message'] = 'Book updated!'
    if request.method == 'DELETE':
        remove_book(book_id)
        response_object['message'] = 'Book removed!'
    return jsonify(response_object)


if __name__ == '__main__':
    app.run()
