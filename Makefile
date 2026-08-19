# ============================================================
# Makefile untuk XyToolsLite - Auto Build .pyc & Run
# ============================================================

.PHONY: run build clean

# Warna teks
GREEN  = \033[1;32m
RED    = \033[1;31m
YELLOW = \033[1;33m
CYAN   = \033[1;36m
WHITE  = \033[1;37m
RESET  = \033[0m

# Nama file
SOURCE = XyToolsLite.py
TARGET = XyToolsLite.pyc
OBFUSCATOR = obfuscate_safe.py

# ============================================================
# GIT PULL (Update dari remote)
# ============================================================
pull:
	@echo "$(CYAN)   >>> Checking for updates...$(RESET)"
	@command -v git >/dev/null 2>&1 || { \
		echo "$(RED)   [-] git not found. Installing...$(RESET)"; \
		pkg install git -y 2>/dev/null || apt install git -y 2>/dev/null; \
	}
	@git pull origin main 2>&1 | grep -E "Already up to date|files? changed|error" | head -1 | \
		sed "s/Already up to date./$(GREEN)   [+] Already up to date.$(RESET)/" | \
		sed "s/error/$(RED)   [-] Git pull error$(RESET)/" || \
		echo "$(YELLOW)   [!] Git pull failed. Continuing with local files...$(RESET)"
	@echo ""

# ============================================================
# RUN (Jalankan tools langsung)
# ============================================================
run: pull $(TARGET)
	@clear
	@echo "$(CYAN)   >>> XYTOOLS LITE ENGINE STARTING...$(RESET)"
	@echo "$(YELLOW)   [+] Checking dependencies...$(RESET)"
	@command -v python3 >/dev/null 2>&1 || { \
		echo "$(RED)   [-] Python3 not found. Installing...$(RESET)"; \
		pkg install python -y 2>/dev/null || apt install python3 -y 2>/dev/null; \
	}
	@python3 -c "import requests" 2>/dev/null || { \
		echo "$(RED)   [-] requests module not found. Installing...$(RESET)"; \
		pip install requests 2>/dev/null || echo "$(YELLOW)   [!] Failed to install requests. Install manually: pip install requests$(RESET)"; \
	}
	@echo "$(GREEN)   [+] Dependencies OK.$(RESET)"
	@sleep 0.5
