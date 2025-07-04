# TradeNote-SelfHost
**TradeNote-SelfHost** is a user-friendly CLI tool that enables traders to host and use [TradeNote]([https://github.com/link-to-tradenote](https://github.com/Eleven-Trading/TradeNote), an open-source trading journal, without dedicated hardware by running it in GitHub Codespaces. The CLI simplifies data backup and restoration, and the `make` commands work on any Linux or macOS system with the required dependencies (e.g., Docker).

## What's New

- **Beta Release**: Initial release with core functionality for hosting TradeNote in GitHub Codespaces.

## Getting Started

### Prerequisites
To run TradeNote-SelfHost, ensure you have:
- A GitHub account to use Codespaces (Recommended)
- Docker installed (for local setups on Linux/macOS)

### Running TradeNote in GitHub Codespaces

1. **Fork the Repository**:
   - Fork [this repository](https://github.com/your-repo/tradenote-selfhost) to your GitHub account.
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
2. Copy your backup file (`tradenote_db_backup.tar.gz`) to the `./backup` directory.
3. Run:
   ```bash
   make restore
   ```
   
## 🕊️ In Memory of Paul Goh

This project is dedicated to the memory of [@paulgoh](https://github.com/paulgoh), my collegue, my friend and my brother who was meant to be the first user of TradeNote-SelfHost. RIP 💙
