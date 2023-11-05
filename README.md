# Installation

## Requirements

- RVM
- NVM
- Docker

## Setup

```bash
rvm install && rvm use
nvm install && nvm use
bundle install
yarn install
docker-compose up
rails db:migrate
bin/vite build --clear --mode=development
rails s
```

### Linters

Add rubocop (Standard) to your IDE and enable automatic code formatting on commit:

```bash
sudo cp ./lib/scripts/linter-pre-commit-script.sh .git/hooks/pre-commit && sudo chmod +x .git/hooks/pre-commit
```

# Gems, standards and tools

## Gems

- **Devise** for authentication
- **Simple Form** Allow quicker and simpler form generation with less repetition
- **Bootstrap** for styling

# Copy template instructions

If you use this repository to copy for a new project. Make sure to do the following:

* Go trough the Devise settings, it's currently set up quite strict with user sessions.

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions