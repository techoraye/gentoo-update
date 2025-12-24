# Contributing to Gentoo-Update

First off, thank you for considering contributing to Gentoo-Update! It's people like you that make Gentoo-Update such a great tool.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps which reproduce the problem**
* **Provide specific examples to demonstrate the steps**
* **Describe the behavior you observed after following the steps**
* **Explain which behavior you expected to see instead and why**
* **Include screenshots and animated GIFs if possible**
* **Include your Gentoo version and init system** (systemd/OpenRC)
* **Include environment details** (bash version, locale, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a step-by-step description of the suggested enhancement**
* **Provide specific examples to demonstrate the steps**
* **Describe the current behavior** and **the expected behavior**
* **Explain why this enhancement would be useful**

### Pull Requests

* Fill in the required template
* Follow the C++ styleguides
* Document new code with comments
* End all files with a newline

## Styleguides

### C++ Style

* Use meaningful variable names
* Follow Google C++ Style Guide where applicable
* Use 4 spaces for indentation
* Use camelCase for functions and variables
* Use UPPER_CASE for constants
* Max line length: 120 characters

### Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

### Documentation

* Use Markdown for all documentation
* Reference functions, classes, and methods in backticks
* Include examples in documentation

## Development Setup

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR-USERNAME/gentoo-update.git`
3. Create a feature branch: `git checkout -b my-new-feature`
4. Make your changes
5. Build and test: `mkdir build && cd build && cmake .. && make`
6. Commit your changes
7. Push to the branch
8. Create a Pull Request

## Additional Notes

### Issue and Pull Request Labels

* `bug` - Something isn't working
* `enhancement` - New feature or request
* `documentation` - Improvements or additions to documentation
* `good first issue` - Good for newcomers
* `help wanted` - Extra attention is needed

## Recognition

Contributors will be recognized in:
* MAINTAINERS.md
* Project releases notes
* GitHub contributors page

Thank you for contributing!

---

For more information on contributing, please see the main [README.md](README.md).
