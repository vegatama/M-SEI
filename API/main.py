import pymysql
from app import app
from config import mysql
from flask import jsonify
from flask import flash, request

# Pembangunan endpoint /login dengan metode POST
@app.route('/login', methods=['POST'])
def login():
    try:        
        _json = request.json
        _username = _json['username']
        _password = _json['password']
        if _username and _password and request.method == 'POST':
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)		
            sqlQuery = "SELECT `username`, `name`, `email` FROM `users` WHERE username = %s and password = %s"
            bindData = (_username, _password)            
            cursor.execute(sqlQuery, bindData)
            loginData = cursor.fetchone()
            respone = jsonify(loginData)
            respone.status_code = 200
            return respone
        else:
            return showMessage()
    except Exception as e:
        print(e)
    finally:
        cursor.close() 
        conn.close()          

# Pembangunan endpoint /user dengan metode GET
@app.route('/user', methods=['GET'])
def users():
    try:
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT `userid`, `username`, `name`, `email` FROM `users`")
        userRows = cursor.fetchall()
        respone = jsonify(userRows)
        respone.status_code = 200
        return respone
    except Exception as e:
        print(e)
    finally:
        cursor.close() 
        conn.close()  

# Pembangunan endpoint /user dengan metode POST
@app.route('/user', methods=['POST'])
def addUser():
    try:        
        _json = request.json
        _username = _json['username']
        _password = _json['password']
        _name = _json['name']
        _email = _json['email']
        if _username and _password and _name and _email and request.method == 'POST':
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)		
            sqlQuery = "INSERT INTO `users`(`username`, `password`, `name`, `email`) VALUES (%s, %s, %s, %s)"
            bindData = (_username, _password, _name, _email)            
            cursor.execute(sqlQuery, bindData)
            conn.commit()
            cursor.execute("SELECT LAST_INSERT_ID() as userid")
            userID = cursor.fetchone()
            respone = jsonify(userID)
            respone.status_code = 200
            return respone
        else:
            return showMessage()
    except Exception as e:
        print(e)
    finally:
        cursor.close() 
        conn.close()          

# jika gagal
@app.errorhandler(404)
def showMessage(error=None):
    message = {
        'status': 404,
        'message': 'Record not found: ' + request.url,
    }
    respone = jsonify(message)
    respone.status_code = 404
    return respone
        
if __name__ == "__main__":
    app.run()