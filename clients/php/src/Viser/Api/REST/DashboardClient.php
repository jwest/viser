<?php

namespace Viser\Api\REST;

use Guzzle\Http\ClientInterface;
use Guzzle\Http\Exception\BadResponseException;
use Viser\Api\REST\Exception\ResponseException;
use Viser\Api\REST\Exception\UnknownException;

class DashboardClient
{
    /**
     * @var ClientInterface
     */
    protected $client;

    /**
     * @var string
     */
    protected $path;

    /**
     * @var string
     */
    protected $version;

    /**
     * @param ClientInterface $client
     */
    public function __construct(ClientInterface $client, $path, $version)
    {
        $this->client = $client;
        $this->path = $path;
        $this->version = $version;
    }

    /**
     * @param string $source
     * @param string $target
     *
     * @return void
     */
    public function event($source, $target)
    {
        $headers = [
            'Content-Type' => 'application/json'
        ];

        $body = new \stdClass();
        $body->source = $source;
        $body->target = $target;

        try {
            $request = $this->client->post(
                $this->path . '/' . $this->version . '/event',
                $headers,
                \json_encode($body)
            );
            $request->send();
        } catch (BadResponseException $e) {
            $response = $e->getResponse();
            $code = $response->getStatusCode();
            $message = $response->getReasonPhrase();
            throw new ResponseException($message, $code);
        } catch (\Exception $e) {
            throw new UnknownException($e->getMessage(), $e->getCode());
        }
    }
}
