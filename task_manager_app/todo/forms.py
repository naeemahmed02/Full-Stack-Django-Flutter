from django import forms
from .models import Todo

class TodoForm(forms.ModelForm):
    class Meta:
        model = Todo
        exclude = ['user']
        fields = ['title', 'priority', 'description', 'due_date']
        widgets = {
            'title': forms.TextInput(attrs={
                'class': 'w-full px-4 py-2 rounded border border-blue-300 focus:outline-none focus:ring-2 focus:ring-blue-500',
                'placeholder': 'Task Title',
            }),
            'priority': forms.Select(attrs={
                'class': 'w-full px-4 py-2 rounded border border-blue-300 focus:outline-none focus:ring-2 focus:ring-blue-500',
            }),
            'description': forms.Textarea(attrs={
                'class': 'w-full px-4 py-2 rounded border border-blue-300 focus:outline-none focus:ring-2 focus:ring-blue-500',
                'rows': 3,
                'placeholder': 'Describe the task...',
            }),
            'due_date': forms.DateInput(attrs={
                'class': 'w-full px-4 py-2 rounded border border-blue-300 focus:outline-none focus:ring-2 focus:ring-blue-500',
                'type': 'date',
            }),
        }
