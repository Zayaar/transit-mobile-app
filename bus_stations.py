from flask import Flask, jsonify, request

app = Flask(__name__)

bus_stations = [
    {
        "name": "Railways",
        "latitude": -1.2921,
        "longitude": 36.8219,
        "destinations": ["Rongai"],
    },
    {
        "name": "Afya Center",
        "latitude": -1.2821,
        "longitude": 36.8229,
        "destinations": ["Rongai"],
    },
    {
        "name": "Ambassadors",
        "latitude": -1.19794,
        "longitude": 36.75537,
        "destinations": ["Rongai"],
    },
    {
        "name": "Odeon",
        "latitude": -1.282769,
        "longitude": 36.825032,
        "destinations": ["Kikuyu"],
    },
    {
        "name": "Commercial",
        "latitude": -1.284282,
        "longitude": 36.826188,
        "destinations": ["Kikuyu"],
    }
]

bus_fares = {
    "Rongai": 100,
    "Kikuyu": 90
}

@app.route('/bus_stations', methods=['GET'])
def get_bus_stations():
    destination = request.args.get('destination')
    if destination:
        filtered_stations = [station for station in bus_stations if destination in station['destinations']]
        fare = bus_fares.get(destination, 0)  # Get the fare, default to 0 if not found
        return jsonify({"bus_stations": filtered_stations, "bus_fare": fare})
    return jsonify({"bus_stations": bus_stations, "bus_fare": 0})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
