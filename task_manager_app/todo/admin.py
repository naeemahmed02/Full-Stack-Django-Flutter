from django.contrib import admin
from . models import Todo

@admin.register(Todo)
class TodoAdmin(admin.ModelAdmin):
    readonly_fields = ('user',)
    list_display = ['title', 'priority', 'due_date', 'created_at']

