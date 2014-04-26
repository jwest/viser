# Viser API clients for Java

## Usage
```java
DashboardClientBuilder builder = new DashboardClientBuilder();
builder.setBaseUrl("http://localhost:3000");
builder.setPath("api");

DashboardClient client = builder.build();

// trigger an event
client.event("source", "target");
```
