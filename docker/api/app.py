from flask import Flask, request, jsonify

# Inicialización de la aplicación Flask
app = Flask(__name__)

@app.route('/api', methods=['GET'])
def hola_mundo():
    return jsonify('Hola mundo')

# Ejecutar la aplicación en el puerto 5000
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
