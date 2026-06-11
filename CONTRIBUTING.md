# Contributing to CDN NoSQL Lab

Thank you for your interest in contributing! This is an open educational material, and all contributions are welcome.

## How to contribute

### 1. Reporting Issues

- Use the [issue tracker](https://github.com/hiltonmbr/cdn-nosql-lab/issues) to check if the problem has already been reported.
- Be clear and descriptive. Include steps to reproduce, error logs, and software versions involved.

### 2. Suggesting Enhancements

- Open an issue with the **enhancement** label describing the improvement.
- Explain the reason for the change and, if possible, how it fits within the project's educational scope.

### 3. Submitting Code (Pull Requests)

1. Fork the repository.
2. Create a descriptive branch:
   ```bash
   git checkout -b feat/my-enhancement
   ```
3. Make your changes following the project conventions:
   - Keep code style consistent with existing code.
   - Jupyter notebooks must be clean (no large outputs or sensitive data).
   - Documentation must be in Brazilian Portuguese.
   - Commits should be atomic with clear messages.
4. Test your changes locally:
   ```bash
   make up
   make setup-env
   ```
5. Submit the PR to the `main` branch.
6. In the PR description, reference the related issue (if any).

### 4. Review

- Maintainers will review the PR within 7 days.
- Changes to container structure or core dependencies require approval from at least 2 maintainers.

## Code of Conduct

Be respectful and constructive. This is a space for collaborative learning.
