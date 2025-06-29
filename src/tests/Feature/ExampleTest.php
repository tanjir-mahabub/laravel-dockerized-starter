<?php

namespace Tests\Feature;

// use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

/**
 * @see \Illuminate\Foundation\Testing\Concerns\MakesHttpRequests
 * @method \Illuminate\Testing\TestResponse get(string $uri, array $headers = [])
 */
class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     * 
     * @return void
     */
    public function test_the_application_returns_a_successful_response(): void
    {
        /** @var \Illuminate\Testing\TestResponse $response */
        $response = $this->get('/');

        $response->assertStatus(200);
    }
}