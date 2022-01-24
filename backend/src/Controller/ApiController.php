<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

class ApiController extends AbstractController
{
    #[Route('/')]
    public function index(): JsonResponse
    {
        return new JsonResponse(['status' => $_ENV['APP_ENV']]);
    }
}
