from django.db import models
from accounts.models import Account

class Todo(models.Model):
    user = models.ForeignKey(Account, on_delete=models.CASCADE, null = True, blank=True)
    title = models.CharField(max_length=500)
    PRIORITY_CHOICES = [
        ('', 'Select Priority'),
        ('low', 'Low'),
        ('medium', 'Medium'),
        ('high', 'High'),
    ]
    priority = models.CharField(max_length=10, choices=PRIORITY_CHOICES)
    description = models.TextField()
    due_date = models.DateTimeField()
    completed = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        verbose_name = 'Todo'
        verbose_name_plural = 'Todos'
    
    def __str__(self):
        return self.title
    
