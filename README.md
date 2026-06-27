# TicTac_Toy_logic
Prolog implementation of Tic-Tac-Logic game with dynamic board generation, rule validation, and logical reasoning. Artificial Intelligence course project demonstrating declarative programming.
# Tic-Tac-Logic Game Simulation

**An intelligent implementation of Tic-Tac-Logic (a variant of Tic-Tac-Toe) using Prolog for logical reasoning and game rules enforcement.**

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Prolog](https://img.shields.io/badge/Prolog-4B0082?logo=prolog&logoColor=white)
![Logic Programming](https://img.shields.io/badge/Logic-Programming-FF6F00.svg)

**A Prolog-based console game that simulates a logical version of Tic-Tac-Toe with strict winning/losing conditions, dynamic board generation, and rule validation.**

![Game Screenshot](screenshot.png)

## ✨ Features

- Dynamic board generation (N × N grid)
- Intelligent move validation and rule enforcement
- Win condition detection (rows, columns, diagonals)
- Equality checks and cell filling logic
- Console-based interactive gameplay
- Educational demonstration of Logic Programming concepts

## 🛠 Technologies Used

- **Language**: Prolog (SWI-Prolog)
- **Paradigm**: Logic Programming & Declarative Programming
- **Key Concepts**: Recursion, Backtracking, Pattern Matching, Dynamic Facts (`assert`)

## 📋 Project Details

- **Project Title**: محاكاة لعبة Tic Tac Logic
- **University**: Damascus University - Faculty of Informatics Engineering
- **Course**: Artificial Intelligence
- **Year**: 2023

## 🎯 Main Components

- Board construction (`build_patch`, `build_rows`, `build_columns`)
- Move insertion with validation (`insert_symbol`)
- Win/Loss condition checking
- Row equality and symbol counting predicates
- Full board filling detection

## 🚀 How to Run

1. Install **SWI-Prolog**
2. Load the file:
   ```prolog
   [tic_tac_logic].
