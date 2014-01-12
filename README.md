Viser - vizualization services tool
-----------------------------------

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
  "source": "Moderacja",
  "target": "Front"
}
```
