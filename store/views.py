from django.http import JsonResponse
from .models import Product

def products(request):
    products = Product.objects.all().order_by('name')
    return JsonResponse(list(products.values()), safe=False)
    
