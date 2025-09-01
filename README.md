[![Test](https://github.com/gitricko/tradenote-selfhost/actions/workflows/test.yml/badge.svg)](https://github.com/gitricko/tradenote-selfhost/actions/workflows/test.yml)
[![Codacy](https://github.com/gitricko/tradenote-selfhost/actions/workflows/codacy.yml/badge.svg)](https://github.com/gitricko/tradenote-selfhost/actions/workflows/codacy.yml)
![GitHub License](https://img.shields.io/github/license/gitricko/tradenote-selfhost)

# TradeNote-SelfHost
**TradeNote-SelfHost** is a user-friendly CLI tool that enables traders to host and use [TradeNote](https://github.com/Eleven-Trading/TradeNote), an open-source trading journal, without dedicated hardware by running it in GitHub Codespaces. The CLI simplifies data backup and restoration, and the `make` commands work on any Linux or macOS system with the required dependencies (e.g., Docker).

## What's New

- Documentation and code to support hosting on MacOS or any linux machine
- Instructions on how to set forked repo to private
- Create a new make directive `update-src-deps` to allow update from this repository after forked repo is private

## Getting Started

### Prerequisites
To run TradeNote-SelfHost, ensure you have:
- a GitHub account to use Codespaces (No additional software requirements)
- Linux/macOS:
  - Docker installed with `docker compose` plugin. Use [brew-install-docker-compose](https://formulae.brew.sh/formula/docker-compose)
  - GIT cli is installed with `git-lfs` plugin installed. Use [brew-install-git-lfs](https://formulae.brew.sh/formula/git-lfs)

### Running TradeNote in GitHub Codespaces (Recommended)

1. **Fork the Repository**:
   - Fork or copy all files from this repository to your GitHub account.
   - Open the repository in GitHub, click the green **Code** button, and select **Create Codespace** to launch a Codespace instance.
   - ![Launch Codespace](./docs/images/codespace.png)

2. **Start TradeNote**:
   - In the Codespace terminal, run:
     ```bash
     make start
     ```
   - Once the service starts, find the URI in the **Ports** tab of Codespace. Click the forwarded address for port `8080` to access TradeNote.
   - ![Ports Tab](./docs/images/ports.png)

3. **Log In**:
   - Use the default credentials defined in the `Makefile` variable `TN_USER` (username and password are the same).
     - Default is: `tn@tn`
   - Alternatively, create a new user via the TradeNote interface.

### Useful Commands

Here are the primary `make` commands you need:

- **`make start`**:
  - Starts the TradeNote service.
- **`make backup`**:
  - Creates a backup of your data as a `.tar.gz` file, stored in `./backup/tradenote_db_backup.tar.gz`.
  - **Tip**: Commit this file to your GitHub repository periodically to secure your backup.
- **`make restore`**:
  - Restores your data from the backup file in a new Codespace instance (e.g., after GitHub deletes an inactive Codespace after 30 days).

### Restoring Data
If you need to start a new Codespace instance:
1. Fork the repository and launch a new Codespace (as described above).
2. Copy your backup file (`tradenote_db_backup.tar.gz`) to the `./backup` directory or pull from your git repository.
3. Run:
   ```bash
   make restore
   ```
   
### Accessing Mongo Express
TradeNote-SelfHost includes [Mongo Express](https://github.com/mongo-express/mongo-express), a web-based interface for viewing and managing your TradeNote database (if needed)

1. **Start the Service**:
   - Run `make start-mongo-express` to launch Mongo Express service as it is not started by default.
   - Once the services start, locate the Mongo Express URI in the **Ports** tab of Codespace. Click the forwarded address for port `8081` to access Mongo Express.
   - ![Ports Tab](./docs/images/ports2.png)

2. **Log In**:
   - Use the default credentials defined in the `docker-compose.yml` file:
     - **Username**: `tn`
     - **Password**: `tn`

3. **Usage**:
   - Mongo Express allows you to browse, edit, or query your TradeNote database directly from the web interface.
   - **Note**: Be cautious when modifying data, as changes are applied directly to the database.

## Security Considerations for Running TradeNote in Codespaces

Running TradeNote in GitHub Codespaces is secure, as access to the Codespace URI is restricted to the GitHub user who owns the repository. This inherently protects the default credentials for TradeNote and Mongo Express (defined in `docker-compose.yml`). However, to ensure your data remains secure, follow these best practices:

- **Keep Your Repository Private**: Ensure your GitHub repository is set to private to prevent unauthorized access to your backup file (`./backup/tradenote_db_backup.tar.gz`) if you commit it to the repository.
- **Limit Codespace Access**: Only share Codespace access with trusted collaborators via GitHub repository permissions.
- **Secure Backup Storage**: If committing backups to GitHub, consider encrypting the backup file (`tradenote_db_backup.tar.gz`) before committing to add an extra layer of security.
- **Monitor Codespace Usage**: Regularly check your GitHub Codespaces for active instances, as inactive instances are deleted after 30 days, potentially requiring data restoration.

By following these steps, you can minimize security risks and safely use TradeNote in Codespaces.

## Setting your Forked tradenote-selfhost Repository to Private
Forked repositories on GitHub are public by default, which can pose a security risk if you commit sensitive files like your TradeNote database backup (`tradenote_db_backup.tar.gz`). To protect your data, convert your forked repository to private by making it standalone first. Follow these steps:

- **Navigate to Repository Settings**: Go to your forked `tradenote-selfhost` repository on GitHub and click on the **Settings** tab at the top.
- **Leave the Fork Network**: Scroll down to the **Danger Zone** section at the bottom of the General settings page. Click the **Leave fork network** button to unlink your repository from the original fork network, transforming it into a standalone repository. Confirm the action when prompted.
- **Change Visibility**: Once unlinked, the **Change visibility** button in the Danger Zone will become available. Click it, select **Change to private**, and confirm the change. Your repository is now private and inaccessible to the public.
### Updating Your Private Repository with latest changes from this repository
After converting your forked repository to private, you may still want to incorporate updates from the original tradenote-selfhost repository. To do this, use the make command:

```bash
make update-src-deps
```
- Preserves Your Files: Any additional files or folders you created will remain untouched.
- Overwrites Matching Files: If files exist both in your repository and the upstream source, they will be overwritten with the latest version.
- Best Practice: Before committing changes to your private repository, run a git diff to review modifications and ensure nothing important is unintentionally overwritten.

## 🕊️ [In Memory of Paul Goh](https://gofund.me/6789235f)

This project is dedicated to the memory of [@paulgoh](https://github.com/paulgoh), my collegue, my friend and my brother who was meant to be the first user of TradeNote-SelfHost. RIP 💙
