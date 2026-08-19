# ============================================================
# Makefile untuk XyToolsLite - Auto Build .pyc & Run
# ============================================================

.PHONY: run pull check-deps

# Warna teks
GREEN  = \033[1;32m
RED    = \033[1;31m
YELLOW = \033[1;33m
CYAN   = \033[1;36m
WHITE  = \033[1;37m
RESET  = \033[0m

# Nama file
TARGET = XyToolsLite.pyc

# ============================================================
# GIT PULL
# ============================================================
pull:
	@echo "$(CYAN)   >>> Checking for updates...$(RESET)"
	@command -v git >/dev/null 2>&1 || { \
		echo "$(RED)   [-] git not found. Installing...$(RESET)"; \
		pkg install git -y 2>/dev/null || apt install git -y 2>/dev/null; \
	}
	@git pull origin main 2>&1 | grep -qE "Already up to date" && \
		echo "$(GREEN)   [+] Already up to date.$(RESET)" || \
		echo "$(YELLOW)   [!] Git pull selesai atau ada perubahan.$(RESET)"
	@echo ""

# ============================================================
# CEK & INSTALL DEPENDENCIES
# ============================================================
check-deps:
	@echo "$(YELLOW)   [+] Checking Python3...$(RESET)"
	@command -v python3 >/dev/null 2>&1 || { \
		echo "$(RED)   [-] Python3 not found. Installing...$(RESET)"; \
		pkg install python -y 2>/dev/null || apt install python3 -y 2>/dev/null; \
	}
	@echo "$(GREEN)   [+] Python3 OK.$(RESET)"

	@echo "$(YELLOW)   [+] Checking pip...$(RESET)"
	@command -v pip >/dev/null 2>&1 || command -v pip3 >/dev/null 2>&1 || { \
		echo "$(RED)   [-] pip not found. Installing...$(RESET)"; \
		python3 -m ensurepip --upgrade 2>/dev/null || \
		pkg install python-pip -y 2>/dev/null || \
		apt install python3-pip -y 2>/dev/null; \
	}
	@echo "$(GREEN)   [+] pip OK.$(RESET)"

	@echo "$(YELLOW)   [+] Checking requests...$(RESET)"
	@python3 -c "import requests" 2>/dev/null || { \
		echo "$(RED)   [-] requests not found. Installing...$(RESET)"; \
		pip install requests 2>/dev/null || pip3 install requests 2>/dev/null; \
	}
	@echo "$(GREEN)   [+] requests OK.$(RESET)"

	@echo "$(YELLOW)   [+] Checking urllib3...$(RESET)"
	@python3 -c "import urllib3" 2>/dev/null || { \
		echo "$(RED)   [-] urllib3 not found. Installing...$(RESET)"; \
		pip install urllib3 2>/dev/null || pip3 install urllib3 2>/dev/null; \
	}
	@echo "$(GREEN)   [+] urllib3 OK.$(RESET)"

	@echo "$(YELLOW)   [+] Checking colorama...$(RESET)"
	@python3 -c "import colorama" 2>/dev/null || { \
		echo "$(RED)   [-] colorama not found. Installing...$(RESET)"; \
		pip install colorama 2>/dev/null || pip3 install colorama 2>/dev/null; \
	}
	@echo "$(GREEN)   [+] colorama OK.$(RESET)"

	@echo "$(YELLOW)   [+] Checking bs4 (BeautifulSoup)...$(RESET)"
	@python3 -c "import bs4" 2>/dev/null || { \
		echo "$(RED)   [-] bs4 not found. Installing...$(RESET)"; \
		pip install beautifulsoup4 2>/dev/null || pip3 install beautifulsoup4 2>/dev/null; \
	}
	@echo "$(GREEN)   [+] bs4 OK.$(RESET)"

	@echo "$(YELLOW)   [+] Checking lxml...$(RESET)"
	@python3 -c "import lxml" 2>/dev/null || { \
		echo "$(RED)   [-] lxml not found. Installing...$(RESET)"; \
		pip install lxml 2>/dev/null || pip3 install lxml 2>/dev/null; \
	}
	@echo "$(GREEN)   [+] lxml OK.$(RESET)"

	@echo "$(YELLOW)   [+] Checking cloudscraper...$(RESET)"
	@python3 -c "import cloudscraper" 2>/dev/null || { \
		echo "$(RED)   [-] cloudscraper not found. Installing...$(RESET)"; \
		pip install cloudscraper 2>/dev/null || pip3 install cloudscraper 2>/dev/null; \
	}
	@echo "$(GREEN)   [+] cloudscraper OK.$(RESET)"

	@echo ""
	@echo "$(GREEN)   [+] Semua dependencies OK.$(RESET)"
	@echo ""

# ============================================================
# RUN
# ============================================================
run: pull check-deps
	@clear
	@echo "$(CYAN)   >>> XYTOOLS LITE ENGINE STARTING...$(RESET)"
	@sleep 0.5
	@if [ ! -f $(TARGET) ]; then \
		echo "$(RED)   [-] File $(TARGET) tidak ditemukan!$(RESET)"; \
		exit 1; \
	fi
	@python3 $(TARGET)
