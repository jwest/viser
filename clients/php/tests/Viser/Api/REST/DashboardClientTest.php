<?php

namespace Viser\Api\REST;

use Guzzle\Http\Exception\BadResponseException;
use Viser\Api\REST\DashboardClient;

class DashboardClientTest extends \PHPUnit_Framework_TestCase
{
    protected $headers;
    protected $body;
    protected $response;
    protected $request;
    protected $client;
    protected $dashboard;

    public function setUp()
    {
        $this->headers = [
            'Content-Type' => 'application/json'
        ];

        $message = new \stdClass();
        $message->source = 'source';
        $message->target = 'target';

        $this->body = \json_encode($message);

        $this->response = $this->getMock(
            '\Guzzle\Http\Message\Response',
            ['getStatusCode', 'getReasonPhrase'],
            [],
            '',
            false
        );

        $this->request = $this->getMock(
            '\Guzzle\Http\Message\Request',
            ['send'],
            [],
            '',
            false
        );

        $this->client = $this->getMock('\Guzzle\Http\ClientInterface');
        $this->dashboard = new DashboardClient($this->client);
        $this->dashboard->setPath('/path');
        $this->dashboard->setVersion('version');
    }

    /**
     * @test
     */
    public function shouldTriggerEvent()
    {
        $this->request->expects($this->once())
            ->method('send');

        $this->client->expects($this->once())
            ->method('post')
            ->with('/path/version/event', $this->headers, $this->body)
            ->will($this->returnValue($this->request));

        $this->dashboard->event('source', 'target');
    }

    /**
     * @test
     * @expectedException \Viser\Api\REST\Exception\ResponseException
     */
    public function shouldThrowResponseExceptionOnError()
    {
        $this->response->expects($this->once())
            ->method('getStatusCode')
            ->will($this->returnValue(400));
        $this->response->expects($this->once())
            ->method('getReasonPhrase')
            ->will($this->returnValue('Bad request'));

        $badResponse = new BadResponseException();
        $badResponse->setResponse($this->response);

        $this->request->expects($this->once())
            ->method('send')
            ->will($this->throwException($badResponse));

        $this->client->expects($this->once())
            ->method('post')
            ->with('/path/version/event', $this->headers, $this->body)
            ->will($this->returnValue($this->request));

        $this->dashboard->event('source', 'target');
    }

    /**
     * @test
     * @expectedException \Viser\Api\REST\Exception\UnknownException
     */
    public function shouldThrowUnknownExceptionOnUnrecognizedError()
    {
        $this->request->expects($this->once())
            ->method('send')
            ->will(
                $this->throwException(
                    new \RuntimeException('some message', 123)
                )
            );

        $this->client->expects($this->once())
            ->method('post')
            ->with('/path/version/event', $this->headers, $this->body)
            ->will($this->returnValue($this->request));

        $this->dashboard->event('source', 'target');
    }
}
