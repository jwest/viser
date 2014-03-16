<?php

namespace Viser\Api\REST;

use Guzzle\Http\Client;

class DashboardClientBuilder
{
    /**
     * @var string
     */
    protected $baseUrl;

    /**
     * @var string
     */
    protected $path;

    /**
     * @var string
     */
    protected $apiVersion;

    public function __construct()
    {
        $this->baseUrl = 'http://localhost:3000';
        $this->path = '/api';
        $this->apiVersion = 'v1';
    }

    /**
     * @param string $baseUrl
     *
     * @return DashboardClientBuilder
     */
    public function setBaseUrl($baseUrl)
    {
        $this->baseUrl = $baseUrl;
        return $this;
    }

    /**
     * @param string $path
     *
     * @return DashboardClientBuilder
     */
    public function setPath($path)
    {
        $this->path = $path;
        return $this;
    }

    /**
     * @param string $apiVersion
     *
     * @return DashboardClientBuilder
     */
    public function setApiVersion($apiVersion)
    {
        $this->apiVersion = $apiVersion;
        return $this;
    }

    /**
     * @return DashboardClient
     */
    public function build()
    {
        $client = new Client($this->baseUrl);

        $dashboardClient = new DashboardClient($client);
        $dashboardClient
            ->setPath($this->path)
            ->setVersion($this->apiVersion);

        return $dashboardClient;
    }
}
