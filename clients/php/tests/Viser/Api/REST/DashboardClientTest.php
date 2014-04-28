<?php

namespace Viser\Api\REST;

use Guzzle\Http\Exception\BadResponseException;
use Viser\Api\REST\DashboardClient;

class DashboardClientTest extends \PHPUnit_Framework_TestCase
{
    protected $headers;
    protected $response;
    protected $request;
    protected $client;
    protected $dashboard;

    public function setUp()
    {
        $this->headers = [
            'Content-Type' => 'application/json'
        ];

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
        $this->dashboard = new DashboardClient(
            $this->client, '/path', 'version'
        );
    }

    /**
     * @test
     */
    public function shouldTriggerEvent()
    {
        $message = new \stdClass();
        $message->source = 'source';
        $message->target = 'target';
        $message->id = 'client id';
        $message = \json_encode($message);

        $this->request->expects($this->once())
            ->method('send');

        $this->client->expects($this->once())
            ->method('post')
            ->with('/path/version/event', $this->headers, $message)
            ->will($this->returnValue($this->request));

        $this->dashboard->event('source', 'target', 'client id');
    }

    /**
     * @test
     */
    public function shouldTriggerEventWithEmptyId()
    {
        $message = new \stdClass();
        $message->source = 'source';
        $message->target = 'target';
        $message->id = '';
        $message = \json_encode($message);

        $this->request->expects($this->once())
            ->method('send');

        $this->client->expects($this->once())
            ->method('post')
            ->with('/path/version/event', $this->headers, $message)
            ->will($this->returnValue($this->request));

        $this->dashboard->event('source', 'target');
    }

    /**
     * @test
     * @expectedException \Viser\Api\REST\Exception\ResponseException
     */
    public function shouldThrowResponseExceptionOnError()
    {
        $message = new \stdClass();
        $message->source = 'source';
        $message->target = 'target';
        $message->id = 'client id';
        $message = \json_encode($message);

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
            ->with('/path/version/event', $this->headers, $message)
            ->will($this->returnValue($this->request));

        $this->dashboard->event('source', 'target', 'client id');
    }

    /**
     * @test
     * @expectedException \Viser\Api\REST\Exception\UnknownException
     */
    public function shouldThrowUnknownExceptionOnUnrecognizedError()
    {
        $message = new \stdClass();
        $message->source = 'source';
        $message->target = 'target';
        $message->id = 'client id';
        $message = \json_encode($message);

        $this->request->expects($this->once())
            ->method('send')
            ->will(
                $this->throwException(
                    new \RuntimeException('some message', 123)
                )
            );

        $this->client->expects($this->once())
            ->method('post')
            ->with('/path/version/event', $this->headers, $message)
            ->will($this->returnValue($this->request));

        $this->dashboard->event('source', 'target', 'client id');
    }
}
