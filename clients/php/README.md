# Viser API clients for PHP

## Installation via composer
```bash
curl -sS https://getcomposer.org/installer | php
php composer.phar install
```

## Usage
```php
use Viser\Api\REST\DashboardClientBuilder;

$builder = new DashboardClientBuilder();
$builder
    ->setBaseUrl('http://localhost:3000')
    ->setPath('/api');
$client = $builder->build();

// send event
$client->event('source', 'target');
```
