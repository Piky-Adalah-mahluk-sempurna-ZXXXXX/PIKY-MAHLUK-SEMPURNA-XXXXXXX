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
# RUN (Jalankan tools langsung)
# ============================================================
run: $(TARGET)
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
	@echo "$(CYAN)   [+] Running $(TARGET)...$(RESET)"
	@python3 $(TARGET)

# ============================================================
# BUILD (Buat file .pyc dari .py)
# ============================================================
build: $(SOURCE)
	@echo "$(YELLOW)   [+] Building $(TARGET) from $(SOURCE)...$(RESET)"
	@if [ ! -f $(OBFUSCATOR) ]; then \
		echo "$(RED)   [-] obfuscate_safe.py not found!$(RESET)"; \
		echo "$(YELLOW)   [!] Please place obfuscate_safe.py in the same folder.$(RESET)"; \
		exit 1; \
	fi
	@python3 $(OBFUSCATOR) $(SOURCE) $(TARGET)
	@echo "$(GREEN)   [+] Build complete!$(RESET)"
	@echo "$(CYAN)   [+] You can now run: make run$(RESET)"

# ============================================================
# CLEAN (Hapus file .pyc dan lock)
# ============================================================
clean:
	@echo "$(YELLOW)   [+] Cleaning build files...$(RESET)"
	@rm -f $(TARGET) ~/.xytools_lite.lock
	@echo "$(GREEN)   [+] Cleaned.$(RESET)"
