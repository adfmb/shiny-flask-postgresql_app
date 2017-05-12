import os
import json
from flask import Flask, jsonify, abort, request, make_response, url_for
from flask_httpauth import HTTPBasicAuth
import psycopg2

hostname = "bd"
app = Flask(__name__)
auth = HTTPBasicAuth()

@auth.get_password
def get_password(username):
    if username == 'adfmb':
        return 'holiii'
    return None

@auth.error_handler
def unauthorized():
    return make_response(jsonify( { 'Gandalf says': 'U should NIIIOOO PASSH' } ), 403)
    # return 403 instead of 401 to prevent browsers from displaying the default auth dialog
    
@app.errorhandler(400)
def not_found(error):
    return make_response(jsonify( { 'error': 'Bad request' } ), 400)

@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify( { 'error': 'Not found' } ), 404)

tasks = [
    {
        'id': 1,
        'title': u'Buy groceries',
        'description': u'Milk, Cheese, Pizza, Fruit, Tylenol', 
        'done': False
    },
    {
        'id': 2,
        'title': u'Learn Python',
        'description': u'Need to find a good Python tutorial on the web', 
        'done': False
    }
]

def make_public_task(task):
    new_task = {}
    for field in task:
        if field == 'id':
            new_task['uri'] = url_for('get_task', task_id = task['id'], _external = True)
        else:
            new_task[field] = task[field]
    return new_task
    
@app.route('/todo/api/v1.0/tasks', methods = ['GET'])
#@auth.login_required
def get_tasks():
    return jsonify( { 'tasks': list(map(make_public_task, tasks)) } )

@app.route('/todo/api/v1.0/tasks/<int:task_id>', methods = ['GET'])
#@auth.login_required
def get_task(task_id):
    task = [task for task in tasks if task['id'] == task_id]
    if len(task) == 0:
        abort(404)
    return jsonify( { 'task': make_public_task(task[0]) } )

@app.route('/todo/api/v1.0/tasks', methods = ['POST'])
@auth.login_required
def create_task():
    if not request.json or not 'title' in request.json:
        abort(400)
    task = {
        'id': tasks[-1]['id'] + 1,
        'title': request.json['title'],
        'description': request.json.get('description', ""),
        'done': False
    }
    tasks.append(task)
    return jsonify( { 'task': make_public_task(task) } ), 201

@app.route('/todo/api/v1.0/tasks/<int:task_id>', methods = ['PUT'])
@auth.login_required
def update_task(task_id):
    task = [task for task in tasks if task['id'] == task_id]
    if len(task) == 0:
        abort(404)
    if not request.json:
        abort(400)
    if 'title' in request.json and type(request.json['title']) != unicode:
        abort(400)
    if 'description' in request.json and type(request.json['description']) is not unicode:
        abort(400)
    if 'done' in request.json and type(request.json['done']) is not bool:
        abort(400)
    task[0]['title'] = request.json.get('title', task[0]['title'])
    task[0]['description'] = request.json.get('description', task[0]['description'])
    task[0]['done'] = request.json.get('done', task[0]['done'])
    return jsonify( { 'task': make_public_task(task[0]) } )
    
@app.route('/todo/api/v1.0/tasks/<int:task_id>', methods = ['DELETE'])
@auth.login_required
def delete_task(task_id):
    task = [task for task in tasks if task['id'] == task_id]
    if len(task) == 0:
        abort(404)
    tasks.remove(task[0])
    return jsonify({ 'result': True })

@app.route('/', methods = ['GET'])                                                  
#@auth.login_required
def query():                                                                             
    # connect to an existing database                         

    # conn=psycopg2.connect("host=192.168.99.100 port=5432 dbname=dpa user=postgres")                                    
    conn=psycopg2.connect("host={} port=5432 dbname=dpa user=postgres password=postgres".format(hostname))                                    
    # open a cursor to perform database operations                                  
    cur=conn.cursor()                                                                    
    # execute command 
    ## cur.execute("SELECT * FROM iris;")
    #columns = (
    #    'sepal_length','sepal_width','petal_length','petal_width','class'
    #)
    #results = []
    #for row in cur.fetchall():
    #    results.append(dict(zip(columns, row)))

    cur.execute('select array_agg(row_to_json(iris)) from iris;')
    res=cur.fetchall()
    return json.dumps(res[0][0], indent=2)

    ## return json.dumps(results, indent=2)


if __name__ == "__main__":
    port = int(os.environ.get("API_PORT", 8080))
    app.run(host="0.0.0.0", port = port)