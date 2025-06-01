from django.shortcuts import render, redirect, get_object_or_404
from .models import Todo
from .forms import TodoForm
from django.contrib.auth.decorators import login_required

@login_required(login_url='login')
def todo_list(request):
    filter_val = request.GET.get('filter', '')
    if filter_val == 'active':
        todos = Todo.objects.filter(completed=False, user=request.user).order_by('-created_at')
    elif filter_val == 'completed':
        todos = Todo.objects.filter(completed=True, user=request.user).order_by('-created_at')
    else:
        todos = Todo.objects.filter(user=request.user).order_by('-created_at')
    
    form = TodoForm()
    return render(request, 'todo/todo_list.html', {
        'todo_list': todos,
        'todo_form': form
    })


@login_required(login_url='login')
def create_todo(request):
    if request.method == 'POST':
        form = TodoForm(request.POST)
        if form.is_valid():
            todo = form.save(commit=False)
            todo.user = request.user  # Attach logged-in user
            todo.save()
    return redirect('todo-list')


@login_required(login_url='login')
def toggle_status(request, pk):
    todo = get_object_or_404(Todo, pk=pk, user=request.user)  # Access restricted
    todo.completed = not todo.completed
    todo.save()
    return redirect('todo-list')


@login_required(login_url='login')
def delete_todo(request, pk):
    todo = get_object_or_404(Todo, pk=pk, user=request.user)  # Access restricted
    todo.delete()
    return redirect('todo-list')


@login_required(login_url='login')
def edit_todo(request, pk):
    todo = get_object_or_404(Todo, pk=pk, user=request.user)  # Access restricted
    if request.method == "POST":
        todo_form = TodoForm(request.POST, instance=todo)
        if todo_form.is_valid():
            todo_form.save()
            return redirect('todo-list')
    else:
        todo_form = TodoForm(instance=todo)
    
    context = {
        'todo_form': todo_form,
        'todo': todo
    }
    return render(request, 'todo/edit_todo.html', context)
