<?php

namespace Islandora\Services;

require_once __DIR__.'/../vendor/autoload.php';

use Silex\Application;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\HttpKernelInterface;
use Psr\Http\Message\ResponseInterface;
use Silex\Provider\TwigServiceProvider;
use Islandora\ResourceService\Provider\ResourceServiceProvider;
use Islandora\CollectionService\Provider\CollectionServiceProvider;
use Islandora\TransactionService\Provider\TransactionServiceProvider;

date_default_timezone_set('UTC');

$app = new Application();

$app['debug'] = true;
$app->register(new \Silex\Provider\ServiceControllerServiceProvider());
// TODO: Not register all template directories right now.
$app->register(new \Silex\Provider\TwigServiceProvider(), array(
  'twig.path' => array(
    __DIR__ . '/../ResourceService/templates',
    __DIR__ . '/../CollectionService/templates',
  ),
));

$islandoraResourceServiceProvider = new ResourceServiceProvider;
$islandoraCollectionServiceProvider = new CollectionServiceProvider;
$islandoraTransactionServiceProvider = new TransactionServiceProvider;

$basepath = array(
  'islandora.BasePath' => __DIR__,
);

$app->register($islandoraResourceServiceProvider, $basepath);
$app->register($islandoraCollectionServiceProvider, $basepath);
$app->register($islandoraTransactionServiceProvider, $basepath);
$app->mount("/islandora", $islandoraResourceServiceProvider);
$app->mount("/islandora", $islandoraCollectionServiceProvider);
$app->mount("/islandora", $islandoraTransactionServiceProvider);

/**
 * Convert returned Guzzle responses to Symfony responses, type hinted.
 */
$app->view(function (ResponseInterface $psr7) {
    return new Response($psr7->getBody(), $psr7->getStatusCode(), $psr7->getHeaders());
});

$app->run();
