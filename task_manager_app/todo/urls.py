from django.contrib import admin
from django.urls import path
from todo import views

urlpatterns = [
    path('', views.todo_list, name='todo-list'),
    path('create/', views.create_todo, name='create-todo'),
    path('toggle/<int:pk>/', views.toggle_status, name='toggle-status'),
    path('delete/<int:pk>/', views.delete_todo, name='delete-todo'),
    path('edit/<int:pk>/', views.edit_todo, name='edit-todo'),
]
