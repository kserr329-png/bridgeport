# Bridgeport Chicago Neighborhood Resource

A complete FiveM resource for simulating the Bridgeport neighborhood in Chicago with dynamic NPCs, teleports, day/night behavior, and robbery jobs.

## Features

- **Dynamic NPCs**: Spawn different NPCs based on location and time of day
- **Teleport System**: Quick travel between key neighborhood locations
- **Day/Night Cycle**: NPC behavior changes based on server time
- **Robbery Jobs**: Interactive robbery spots with risk/reward mechanics
- **Neighborhood Locations**: 
  - 31st & Morgan
  - 32nd & Lituanica  
  - 33rd & Morgan
  - McGuane Park
  - Bridgeport Homes
  - CPD 9th District

## Installation

### Using txAdmin Recipe (Recommended)

1. In txAdmin, go to "Recipes" 
2. Import the `txadmin-recipe.yml` file from this repository
3. Run the recipe to automatically install the resource
4. The resource will be installed to `resources/[bridgeport]/bridgeport`
5. Restart your server

### Manual Installation

1. Download this repository
2. Extract to your server's `resources` folder as `bridgeport`
3. Add `ensure bridgeport` to your `server.cfg`
4. Make sure the `stream` folder contains `bridgeport_draft.ymap`
5. Restart your server

## Configuration

- **Config.lua**: Adjust NPC spawning, day/night hours, and spawn radius
- **Locations.lua**: Modify teleport points and robbery locations
- **Client.lua**: Customize NPC behavior and interactions
- **Server.lua**: Modify robbery success rates and payouts

## Dependencies

This resource is standalone and doesn't require any additional dependencies. However, it supports QBCore framework for money handling if available.

## Notes

- The resource includes a draft ymap file for building proxies
- NPCs will spawn dynamically based on player proximity
- Robbery success rates are higher at night (20:00 - 06:00)
- The resource tries to add money using QBCore when available
- Use CodeWalker to modify the ymap if desired

## Version

Current version: 1.2.0
