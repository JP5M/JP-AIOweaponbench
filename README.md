# IMPORTANT

This is a **forked version** of the original [OT_weaponrepair](https://github.com/OTSTUDIOS/OT_weaponrepair) by OTSTUDIOS, maintained and extended by **JP5M**.

![GitHub all releases](https://img.shields.io/github/downloads/JP5M/JP-AIOweaponbench/total?style=flat-square)

# JP-AIOweaponbench

A FiveM all-in-one weapon bench for use with ox_inventory and ox_lib.

## Features

- **Weapon Repair:** Restore weapon durability using the repair bench.
- **Scratch Serial:** Remove the serial number from a weapon.
- **Weapon Tampering:** Tamper with a weapon, making it dangerous to use.
- **Tampered Weapon Mechanic:** If a player fires a tampered weapon, they will explode and the weapon will be removed from their inventory.
- **Fully integrated with ox_inventory and ox_lib.**

## Installation

1. Ensure you have [ox_inventory](https://github.com/overextended/ox_inventory), [ox_lib](https://github.com/overextended/ox_lib), and [ox_target](https://github.com/overextended/ox_target) installed and running.
2. Place this resource in your `resources` folder.
3. Add `ensure JP-AIOweaponbench` to your `server.cfg`.

## Configuration

- Edit `config.lua` to set up bench locations, required items, and XP rewards.
- Make sure your items (repair kit, scratch kit, tampering kit) are defined in ox_inventory.

## Usage

- Approach a weapon bench and interact to open the menu.
- Choose to repair, scratch, or tamper with your weapon.
- **Warning:** If you tamper with a weapon and then fire it, your character will explode and the weapon will be deleted.

## Dependencies

- ox_inventory
- ox_lib
- ox_target

## Notes

- The script uses server callbacks and events to ensure only the weapon actually held is affected.
- Weapons are matched by slot and metadata to prevent issues with multiple identical weapons.