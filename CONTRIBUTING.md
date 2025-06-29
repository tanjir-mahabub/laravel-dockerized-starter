# Contributing to Laravel Dockerized Starter Template

Thank you for your interest in contributing to the Laravel Dockerized Starter Template! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### 1. Fork the Repository

1. Go to the [repository page](https://github.com/your-username/laravel-dockerized-starter)
2. Click the "Fork" button in the top-right corner
3. Clone your forked repository locally

### 2. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-fix-name
```

### 3. Make Your Changes

- Follow the coding standards
- Add tests if applicable
- Update documentation as needed
- Test your changes thoroughly

### 4. Test Your Changes

```bash
# Start the development environment
make start

# Run tests
make test

# Check if everything works
make health
```

### 5. Commit Your Changes

```bash
git add .
git commit -m "feat: add new feature description"
git push origin feature/your-feature-name
```

### 6. Create a Pull Request

1. Go to your forked repository on GitHub
2. Click "Compare & pull request"
3. Fill out the PR template
4. Submit the PR

## 📋 Pull Request Guidelines

### PR Title Format

Use conventional commit format:

- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `style:` for formatting changes
- `refactor:` for code refactoring
- `test:` for adding tests
- `chore:` for maintenance tasks

### PR Description Template

```markdown
## Description

Brief description of the changes

## Type of Change

- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Configuration change
- [ ] Other (please describe)

## Testing

- [ ] Tested locally with Docker
- [ ] All tests pass
- [ ] Documentation updated

## Checklist

- [ ] Code follows the project's style guidelines
- [ ] Self-review of code completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No breaking changes (or breaking changes documented)
```

## 🏗️ Development Setup

### Prerequisites

- Docker and Docker Compose
- Git
- Make (optional, for using Makefile commands)

### Local Development

```bash
# Clone the repository
git clone https://github.com/your-username/laravel-dockerized-starter.git
cd laravel-dockerized-starter

# Run the setup script
make setup

# Or manually:
docker-compose up -d
docker-compose exec app composer install
docker-compose exec app php artisan key:generate
docker-compose exec app php artisan migrate
```

### Available Commands

```bash
# View all available commands
make help

# Common development commands
make start          # Start all services
make stop           # Stop all services
make logs           # View logs
make shell          # Open shell in app container
make test           # Run tests
make cache          # Clear Laravel caches
```

## 📝 Coding Standards

### PHP/Laravel

- Follow PSR-12 coding standards
- Use meaningful variable and function names
- Add proper PHPDoc comments
- Keep functions small and focused

### Docker

- Use specific version tags for base images
- Optimize layer caching
- Keep Dockerfiles clean and readable
- Add comments for complex operations

### Documentation

- Update README.md for new features
- Add inline comments for complex code
- Update configuration examples
- Keep documentation up to date

## 🧪 Testing

### Running Tests

```bash
# Run all tests
make test

# Run specific test file
docker-compose exec app php artisan test --filter=TestName

# Run with coverage
docker-compose exec app php artisan test --coverage
```

### Test Guidelines

- Write tests for new features
- Ensure existing tests pass
- Use descriptive test names
- Follow AAA pattern (Arrange, Act, Assert)

## 🐛 Bug Reports

### Before Submitting

1. Check existing issues
2. Try to reproduce the bug
3. Check if it's a configuration issue
4. Test with different environments

### Bug Report Template

```markdown
## Bug Description

Clear description of the bug

## Steps to Reproduce

1. Step 1
2. Step 2
3. Step 3

## Expected Behavior

What should happen

## Actual Behavior

What actually happens

## Environment

- OS: [e.g., macOS, Windows, Linux]
- Docker version: [e.g., 20.10.0]
- Docker Compose version: [e.g., 2.0.0]
- Laravel version: [e.g., 11.0]

## Additional Information

Screenshots, logs, or other relevant information
```

## 💡 Feature Requests

### Before Submitting

1. Check if the feature already exists
2. Consider if it fits the project's scope
3. Think about implementation complexity
4. Consider backward compatibility

### Feature Request Template

```markdown
## Feature Description

Clear description of the requested feature

## Use Case

Why this feature would be useful

## Proposed Implementation

How you think it could be implemented

## Alternatives Considered

Other approaches you've considered

## Additional Information

Any other relevant information
```

## 📞 Getting Help

### Questions and Discussions

- Use GitHub Discussions for questions
- Check existing issues and PRs
- Search the documentation

### Communication

- Be respectful and inclusive
- Use clear and concise language
- Provide context for your questions
- Help others when you can

## 🎉 Recognition

Contributors will be recognized in:

- The project README
- Release notes
- GitHub contributors page

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to the Laravel Dockerized Starter Template! 🚀
