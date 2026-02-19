# Created by Jon Allen
# February 2026
# Enhanced Cuckoo Hash Simulator with Seed (T) Rehash
#############################
import curses
import random
import time
import logging
from datetime import datetime

# Setup logging configuration
logging.basicConfig(
    filename='cuckoo_hash_sim.log',
    level=logging.INFO,
    format='%(asctime)s | %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)

def draw_box(win, y, x, height, width, title):
    win.attron(curses.color_pair(3))
    for i in range(width):
        win.addch(y, x + i, curses.ACS_HLINE)
        win.addch(y + height, x + i, curses.ACS_HLINE)
    for i in range(height):
        win.addch(y + i, x, curses.ACS_VLINE)
        win.addch(y + i, x + width, curses.ACS_VLINE)
    win.addch(y, x, curses.ACS_ULCORNER)
    win.addch(y, x + width, curses.ACS_URCORNER)
    win.addch(y + height, x, curses.ACS_LLCORNER)
    try:
        win.move(y + height, x + width)
        win.insch(curses.ACS_LRCORNER)
    except:
        pass
    win.addstr(y, x + 2, f" {title} ")
    win.attroff(curses.color_pair(3))

def show_help(stdscr):
    sh, sw = stdscr.getmaxyx()
    help_win = curses.newwin(sh - 1, sw - 1, 0, 0)
    help_win.clear()
    draw_box(help_win, 0, 0, sh - 2, sw - 2, "CUCKOO HASHING INFORMATION")

    info = [
        ("HOW IT WORKS", "Cuckoo hashing uses two hash tables and two hash functions."),
        ("", "Each key is stored in one of two possible locations."),
        ("INSERTION", "When inserting, if the first location is occupied, the existing"),
        ("", "key is 'kicked out' to its alternative location, potentially causing"),
        ("", "a chain of displacements."),
        ("LOOKUP", "Check both possible locations - if the key is in either, it's a hit."),
        ("COLLISIONS", "If a cycle is detected during insertion, the tables may be rehashed"),
        ("", "with a new seed (T) or stop if using basic hashing."),
        ("", ""),
        ("KEY CONTROLS", ""),
        ("s", "Toggle sequential/random insertion mode"),
        ("+", "Increase simulation speed"),
        ("-", "Decrease simulation speed"),
        ("Space", "Pause/Resume or Reset simulation when stopped"),
        ("T", "Cycle through hash modes: Default -> Enhanced -> Optimal"),
        ("h", "Show this help screen"),
        ("q", "Quit simulation")
    ]

    for i, (title, desc) in enumerate(info):
        y_pos = 2 + i
        if y_pos < sh - 4:
            if title:
                help_win.addstr(y_pos, 2, title, curses.color_pair(2) | curses.A_BOLD)
            help_win.addstr(y_pos, 25, desc)

    help_win.addstr(sh - 4, 4, "-- PRESS ANY KEY TO RETURN --", curses.A_BLINK)
    help_win.refresh()
    help_win.getch()
    del help_win
    stdscr.touchwin()
    stdscr.refresh()

class CuckooHash:
    def __init__(self, size, hash_mode=0):
        self.size = size
        self.table1 = [None] * size
        self.table2 = [None] * size
        self.keys_present = set()
        self.max_kicks = size // 2  # Threshold to detect a cycle
        self.hash_mode = hash_mode  # 0: default, 1: enhanced, 2: optimal
        self.T = 0  # The Seed/Nudge factor (Our T)
        self.rehash_enabled = True  # Enable rehashing by default

    def hash1(self, key):
        if self.hash_mode == 2:  # Optimal
            # Enhanced: Mix key with T and golden ratio prime
            return ((key ^ self.T) * 0x9e3779b9 % (2**32)) % self.size
        elif self.hash_mode == 1:  # Enhanced
            # Multiplicative hashing with Seed T
            return ((key ^ self.T) * 2654435761 % (2**32)) % self.size
        # Default
        return key % self.size

    def hash2(self, key):
        if self.hash_mode == 2:  # Optimal
            # Enhanced: Mix key with shifted T and SHA-2 prime
            return ((key ^ (self.T << 1)) * 0x6a09e667 % (2**32)) % self.size
        elif self.hash_mode == 1:  # Enhanced
            # Secondary hash with Seed T and different prime
            return ((key ^ self.T) * 2246822519 % (2**32)) % self.size
        # Default
        return ((key * 31) + 17) % self.size

    def lookup(self, key):
        pos1 = self.hash1(key)
        if self.table1[pos1] == key: return (1, pos1)
        pos2 = self.hash2(key)
        if self.table2[pos2] == key: return (2, pos2)
        return None

    def insert(self, key):
        if self.lookup(key): return True

        curr_key = key
        for _ in range(self.max_kicks):
            # Try Table 1
            pos1 = self.hash1(curr_key)
            if self.table1[pos1] is None:
                self.table1[pos1] = curr_key
                self.keys_present.add(key)
                return True

            # Kick from Table 1
            curr_key, self.table1[pos1] = self.table1[pos1], curr_key

            # Try Table 2
            pos2 = self.hash2(curr_key)
            if self.table2[pos2] is None:
                self.table2[pos2] = curr_key
                self.keys_present.add(key)
                return True

            # Kick from Table 2
            curr_key, self.table2[pos2] = self.table2[pos2], curr_key

        return False  # Cycle detected

    def force_rehash(self):
        """Increments T and re-inserts all existing keys to resolve collisions."""
        self.T += 1
        existing_keys = list(self.keys_present)
        self.table1 = [None] * self.size
        self.table2 = [None] * self.size
        self.keys_present.clear()

        for k in existing_keys:
            if not self.insert(k):
                # If T still causes a cycle, we need to increment again
                return self.force_rehash()
        return True

    def get_load_factor(self):
        return (len(self.keys_present) / (self.size * 2)) * 100

    def get_hash_mode_name(self):
        if self.hash_mode == 0:
            return "DEFAULT" + (" REHASH" if self.rehash_enabled else " NO REHASH")
        elif self.hash_mode == 1:
            return "ENHANCED" + (" REHASH" if self.rehash_enabled else " NO REHASH")
        else:
            return "OPTIMAL" + (" REHASH" if self.rehash_enabled else " NO REHASH")

def main(stdscr):
    curses.curs_set(0)
    stdscr.nodelay(True)
    curses.start_color()
    curses.init_pair(1, curses.COLOR_GREEN, curses.COLOR_BLACK)
    curses.init_pair(2, curses.COLOR_RED, curses.COLOR_BLACK)
    curses.init_pair(3, curses.COLOR_CYAN, curses.COLOR_BLACK)
    curses.init_pair(4, curses.COLOR_YELLOW, curses.COLOR_BLACK)
    curses.init_pair(5, curses.COLOR_MAGENTA, curses.COLOR_BLACK)
    curses.init_pair(6, curses.COLOR_WHITE, curses.COLOR_BLUE)
    curses.init_pair(7, curses.COLOR_WHITE, curses.COLOR_RED)

    # Splash screen
    total_time = 1.0
    sleep_time = total_time / 3
    for color in [1, 2, 3]:
        stdscr.clear()
        stdscr.attron(curses.color_pair(color))
        y, x = stdscr.getmaxyx()
        line1 = "Cuckoo Hash Sim"
        line2 = "  *******  "
        line3 = " ********* "
        stdscr.addstr(y // 2 - 1, x // 2 - len(line1) // 2, line1)
        stdscr.addstr(y // 2, x // 2 - len(line2) // 2, line2)
        stdscr.addstr(y // 2 + 1, x // 2 - len(line3) // 2, line3)
        stdscr.attroff(curses.color_pair(color))
        stdscr.refresh()
        time.sleep(sleep_time)

    TABLE_SIZE = 16
    hash_mode = 0  # 0: default, 1: enhanced, 2: optimal
    rehash_enabled = True
    cuckoo = CuckooHash(TABLE_SIZE, hash_mode)
    cuckoo.rehash_enabled = rehash_enabled
    history, hits, misses = [], 0, 0
    sim_speed, paused = 0.6, False
    seq_mode, seq_ptr = False, 0
    simulation_stopped = False
    current_key = None
    current_table = None
    current_pos = None

    while True:
        ch = stdscr.getch()
        if ch == ord('q'): break
        if ch == ord(' '):
            if simulation_stopped:
                cuckoo = CuckooHash(TABLE_SIZE, hash_mode)
                cuckoo.rehash_enabled = rehash_enabled
                history, hits, misses, simulation_stopped = [], 0, 0, False
                seq_ptr = 0
            else: paused = not paused
        if ch == ord('s'):
            seq_mode = not seq_mode
            seq_ptr = 0
        if ch == ord('T'):
            # Cycle through hash modes: default -> enhanced -> optimal -> default
            hash_mode = (hash_mode + 1) % 3
            # For optimal mode, toggle rehashing
            if hash_mode == 2:
                rehash_enabled = not rehash_enabled
            cuckoo = CuckooHash(TABLE_SIZE, hash_mode)
            cuckoo.rehash_enabled = rehash_enabled
            history, hits, misses, simulation_stopped = [], 0, 0, False
            seq_ptr = 0
            mode_name = cuckoo.get_hash_mode_name()
            history.append(f"Switched to {mode_name} mode")
            logging.info(f"Switched to {mode_name} mode")
        if ch == ord('+'): sim_speed = max(0.05, sim_speed - 0.1)
        if ch == ord('-'): sim_speed = min(2.0, sim_speed + 0.1)
        if ch == ord('h'): show_help(stdscr)

        if not paused and not simulation_stopped:
            addr = seq_ptr if seq_mode else random.randint(0, 99)
            if seq_mode: seq_ptr = (seq_ptr + 1) % 100
            current_key = addr

            res = cuckoo.lookup(addr)
            if res:
                hits += 1
                current_table, current_pos = res
                history.append(f"HIT: Key {addr:02} at T{res[0]}[{res[1]}] (Load: {cuckoo.get_load_factor():.1f}%)")
                logging.info(f"HIT: Key {addr:02} at T{res[0]}[{res[1]}] (Load: {cuckoo.get_load_factor():.1f}%) - {cuckoo.get_hash_mode_name()}")
            else:
                misses += 1
                if cuckoo.insert(addr):
                    current_table, current_pos = cuckoo.lookup(addr)
                    mode_name = cuckoo.get_hash_mode_name()
                    history.append(f"INS: Key {addr:02} ({mode_name}) (Load: {cuckoo.get_load_factor():.1f}%)")
                    logging.info(f"INS: Key {addr:02} ({mode_name}) (Load: {cuckoo.get_load_factor():.1f}%)")
                else:
                    if cuckoo.rehash_enabled and (hash_mode == 1 or hash_mode == 2):
                        history.append(f"CYCLE! Incrementing T to {cuckoo.T + 1} (Load: {cuckoo.get_load_factor():.1f}%)")
                        logging.warning(f"CYCLE! Incrementing T to {cuckoo.T + 1} (Load: {cuckoo.get_load_factor():.1f}%) - {cuckoo.get_hash_mode_name()}")
                        cuckoo.force_rehash()
                        cuckoo.insert(addr)
                        current_table, current_pos = cuckoo.lookup(addr)
                    else:
                        simulation_stopped = True
                        mode_name = cuckoo.get_hash_mode_name()
                        history.append(f"CRASH: Table Cycle at Key {addr:02} (Load: {cuckoo.get_load_factor():.1f}%) - TABLES FULL")
                        logging.error(f"CRASH: Table Cycle at Key {addr:02} (Load: {cuckoo.get_load_factor():.1f}%) - {mode_name} - TABLES FULL")

        # --- DRAWING ---
        stdscr.clear()
        draw_box(stdscr, 1, 2, TABLE_SIZE + 2, 22, "TABLE 1")
        for i in range(TABLE_SIZE):
            val = cuckoo.table1[i]
            color = curses.color_pair(6) if (current_key == val and current_table == 1 and current_pos == i) else curses.color_pair(4)
            stdscr.addstr(2+i, 4, f"[{i:2}]: {val if val is not None else '--'}", color)

        draw_box(stdscr, 1, 28, TABLE_SIZE + 2, 22, "TABLE 2")
        for i in range(TABLE_SIZE):
            val = cuckoo.table2[i]
            color = curses.color_pair(6) if (current_key == val and current_table == 2 and current_pos == i) else curses.color_pair(5)
            stdscr.addstr(2+i, 30, f"[{i:2}]: {val if val is not None else '--'}", color)

        draw_box(stdscr, 1, 54, 10, 46, "LOG")
        for idx, entry in enumerate(history[-8:]):
            color = curses.color_pair(1) if "HIT" in entry else curses.color_pair(2)
            if "CRASH" in entry or "CYCLE" in entry:
                color = curses.color_pair(7)
            stdscr.addstr(2+idx, 56, entry[:44], color)

        draw_box(stdscr, TABLE_SIZE + 4, 2, 5, 70, "STATS")
        load = cuckoo.get_load_factor()
        stdscr.addstr(TABLE_SIZE+5, 4, f"Hits: {hits} | Misses: {misses} | Load: {load:.1f}%")
        mode_name = cuckoo.get_hash_mode_name()
        stdscr.addstr(TABLE_SIZE+6, 4, f"Hash: {mode_name} | Seed (T): {cuckoo.T}")

        if simulation_stopped:
            stdscr.addstr(TABLE_SIZE + 8, 4, "STOPPED: CYCLE. Press SPACE to reset or T to change mode.", curses.color_pair(7))

        stdscr.addstr(TABLE_SIZE + 10, 2, "[Space] Pause/Reset | [T] Toggle Hash | [s] Mode | [+/-] Speed | [h] Help | [q] Quit")

        draw_box(stdscr, TABLE_SIZE - 4, 54, 6, 46, "SIMULATION" )
        stdscr.addstr(TABLE_SIZE - 3, 56, "Cuckoo Hash Simulator" )
        stdscr.addstr(TABLE_SIZE - 2, 56, "Author:  Jon Allen   " )
        stdscr.addstr(TABLE_SIZE - 1, 56, "Date:    Feb, 2026   " )

        stdscr.refresh()
        time.sleep(sim_speed)

if __name__ == "__main__":
    curses.wrapper(main)
