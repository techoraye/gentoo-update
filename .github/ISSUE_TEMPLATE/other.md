name: Other
description: Something else
labels: ["question"]
assignees: []

body:
  - type: markdown
    attributes:
      value: |
        Please describe your issue or question.

  - type: textarea
    id: description
    attributes:
      label: Description
      description: What would you like to discuss?
    validations:
      required: true

  - type: textarea
    id: context
    attributes:
      label: Additional Context
      description: Any relevant information
