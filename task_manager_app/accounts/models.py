from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin

# User roles
USER_ROLES = [
    ("admin", "Admin"),
    ("user", "User"),
]

class MyAccountManager(BaseUserManager):
    def create_user(self, email, password=None, first_name="", last_name="", username=None):
        if not email:
            raise ValueError("A valid email address is required for user registration.")

        email = self.normalize_email(email)

        user = self.model(
            email=email,
            first_name=first_name,
            last_name=last_name,
            username=email.split('@')[0],  # auto-generate username if not provided
        )
        user.set_password(password)
        user.is_active = False  # user not activated immediately
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password, first_name="", last_name="", username=None):
        user = self.create_user(
            email=email,
            password=password,
            first_name=first_name,
            last_name=last_name,
            username=username or email.split('@')[0],
        )
        user.is_admin = True
        user.is_staff = True
        user.is_superuser = True
        user.is_active = True
        user.save(using=self._db)
        return user

class Account(AbstractBaseUser, PermissionsMixin):
    first_name = models.CharField(max_length=200, blank=True, null=True)
    last_name = models.CharField(max_length=200, blank=True, null=True)
    username = models.CharField(max_length=200, unique=True, blank=True, null=True)
    email = models.EmailField(unique=True)
    phone_number = models.CharField(max_length=20, unique=True, null=True, blank=True)

    role = models.CharField(max_length=10, choices=USER_ROLES, default="user")

    date_joined = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now=True)
    is_admin = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_active = models.BooleanField(default=False)

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []  # only email is required for createsuperuser

    objects = MyAccountManager()

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        return self.is_admin

    def has_module_perms(self, app_label):
        return True

    def get_full_name(self):
        first = self.first_name or ""
        last = self.last_name or ""
        return f"{first} {last}".strip()

    def get_short_name(self):
        return self.first_name or self.email

    class Meta:
        verbose_name = "Account"
        verbose_name_plural = "Accounts"
