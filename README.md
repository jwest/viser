Viser - vizualization services tool
-----------------------------------

[![Build Status](https://travis-ci.org/jwest/viser.png?branch=master)](https://travis-ci.org/jwest/viser)

Use viser for realtime monitoring event flow in your process.

**Build**
```
npm install
```

**Run dashboard**
```
npm start
```
Go to address http://localhost:3000

**Testing (frontend + backend)**
```
npm test
```

**Usage**

If you have emit event try api. Send POST request to address http://localhost:3000/api/v1/event with header
```
Content-Type: application/json
```
... and content:
```json
{
  "id": "f4j139342f34f123e2c12c",  //custom data object id, for identity event
  "source": "Moderacja",
  "target": "Front"
}
```
