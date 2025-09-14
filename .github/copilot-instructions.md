# Bridgeport FiveM Resource

Bridgeport is a FiveM (GTA V multiplayer) resource that creates a dynamic Chicago Bridgeport neighborhood with NPCs, teleports, day/night behavior, and robbery mechanics. This resource is written in Lua and includes client-side, server-side, and shared scripts.

**ALWAYS follow these instructions first and only search or run bash commands when you encounter unexpected information that does not match the information provided here.**

## Working Effectively

### Prerequisites and Setup
- **FiveM Server Required**: This resource only works within a FiveM server environment
- **No Build Process**: This is a pure Lua resource - no compilation or build steps required
- **Installation Time**: Manual setup takes under 30 seconds. txAdmin recipe setup takes under 60 seconds.
- **Download Size**: Resource archive is approximately 12KB
- **No Dependencies**: Works standalone but integrates with QBCore/ESX frameworks

### Manual Installation (Recommended)
1. **Download the resource:**
   ```bash
   wget https://github.com/kserr329-png/bridgeport/archive/refs/heads/main.zip -O bridgeport.zip
   ```

2. **Extract and setup:**
   ```bash
   unzip bridgeport.zip
   mkdir -p resources/bridgeport_final_resource
   mv bridgeport-main/* resources/bridgeport_final_resource/
   ```

3. **Add to server.cfg:**
   ```
   ensure bridgeport_final_resource
   ```

### txAdmin Installation (Alternative)
- Upload `txadmin-recipe.yml` to txAdmin
- The recipe automatically downloads dependencies and sets up the resource
- **NEVER CANCEL**: Recipe execution takes 2-5 minutes depending on internet speed

### Resource Validation
Run this validation after any changes:
```bash
# Create validation script
cat > validate_resource.py << 'EOF'
#!/usr/bin/env python3
import os
import sys
import re

def validate_fivem_resource(resource_path):
    print(f"=== Validating FiveM Resource: {resource_path} ===")
    
    required_files = ['fxmanifest.lua']
    recommended_files = ['client.lua', 'server.lua', 'config.lua']
    
    for file in required_files:
        filepath = os.path.join(resource_path, file)
        if not os.path.exists(filepath):
            print(f"✗ MISSING REQUIRED: {file}")
            return False
        else:
            print(f"✓ Found required: {file}")
    
    for file in recommended_files:
        filepath = os.path.join(resource_path, file)
        if os.path.exists(filepath):
            print(f"✓ Found recommended: {file}")
    
    manifest_path = os.path.join(resource_path, 'fxmanifest.lua')
    with open(manifest_path, 'r') as f:
        manifest_content = f.read()
        
    if "fx_version" in manifest_content and "game 'gta5'" in manifest_content:
        print("✓ Valid FiveM manifest")
        return True
    else:
        print("✗ Invalid manifest")
        return False

if __name__ == "__main__":
    if validate_fivem_resource(sys.argv[1] if len(sys.argv) > 1 else "."):
        print("\n✓ Resource validation PASSED")
    else:
        print("\n✗ Resource validation FAILED")
        sys.exit(1)
EOF

python3 validate_resource.py /path/to/resource
```

## Testing and Validation

### Lua Syntax Validation
**ALWAYS run this after making changes to any .lua files:**
```bash
# Basic Lua syntax check using Python
for f in *.lua; do
    echo "Checking $f..."
    python3 -c "
import re
with open('$f', 'r') as file:
    content = file.read()
    function_count = len(re.findall(r'\bfunction\b', content))
    end_count = len(re.findall(r'\bend\b', content))
    if 'RegisterNetEvent' in content or 'TriggerEvent' in content:
        print('✓ Valid FiveM script')
    else:
        print('⚠ May not be FiveM script')
    print(f'Functions: {function_count}, Ends: {end_count}')
"
done
```

### Manual Testing Requirements
**CRITICAL**: Since this resource requires a running FiveM server, you cannot fully test functionality in a sandboxed environment. However, you can:

1. **Validate file structure** using the validation script above
2. **Check Lua syntax** using the syntax validation
3. **Verify manifest correctness** by ensuring all referenced scripts exist

**For full testing, you would need:**
- A running FiveM server
- QBCore or ESX framework installed  
- In-game testing of teleports, NPCs, and robbery mechanics

## Resource Structure and Key Files

### Core Files
- **`fxmanifest.lua`**: Resource manifest - defines scripts and metadata
- **`client.lua`**: Client-side logic (170 lines) - handles NPCs, teleports, UI
- **`server.lua`**: Server-side logic (55 lines) - time sync, robbery handling  
- **`config.lua`**: Configuration settings (8 lines) - spawn radius, timing
- **`locations.lua`**: Coordinate definitions (16 lines) - teleports, robbery spots

### Additional Files
- **`bridgeport_draft.ymap`**: GTA V map file with building proxies
- **`txadmin-recipe.yml`**: Automated installation recipe
- **`bridgeport_setup.yaml`**: Alternative setup configuration
- **`README.md`**: Basic installation instructions

### Key Configuration Points
- **Spawn radius**: `Config.spawnRadius = 12.0` (NPC wander distance)
- **Max NPCs per POI**: `Config.maxNPCsPerPOI = 4` 
- **Day/Night cycle**: Day starts at 6:00, night at 20:00
- **Respawn delay**: 30 seconds for dead NPCs

## Common Tasks and Commands

### Making Code Changes
1. **ALWAYS backup** the working resource before changes
2. **Edit configuration** in `config.lua` for behavior tweaks
3. **Modify locations** in `locations.lua` for new teleports/robbery spots
4. **Validate syntax** after every change using the validation script
5. **Test in FiveM server** - the only way to verify functionality

### Framework Integration
- **QBCore**: Resource includes QBCore money handling in `server.lua`
- **ESX**: Can be adapted by modifying server-side money functions
- **Standalone**: Works without frameworks but with limited functionality

### File Modification Guidelines
- **Never modify** `fxmanifest.lua` unless adding new script files
- **Config changes**: Modify `config.lua` for behavioral adjustments
- **New features**: Add to `client.lua` (UI/NPCs) or `server.lua` (data handling)
- **Coordinates**: Update `locations.lua` for new locations

### Debugging Common Issues
- **Resource not loading**: Check `fxmanifest.lua` syntax
- **Scripts not executing**: Verify file paths in manifest match actual files
- **Framework errors**: Check server console for QBCore/ESX compatibility issues

## CRITICAL REMINDERS

- **NO BUILD PROCESS**: This is pure Lua - no compilation needed
- **NO TESTS**: FiveM resources cannot be unit tested outside server environment  
- **VALIDATION ONLY**: Use syntax checking and structure validation scripts
- **ALWAYS VALIDATE**: Run validation script after any file changes
- **FRAMEWORK DEPENDENT**: Full functionality requires QBCore or ESX framework
- **SERVER REQUIRED**: Cannot test actual functionality without FiveM server

## Quick Reference Commands

```bash
# Download latest version (takes ~1 second)
wget https://github.com/kserr329-png/bridgeport/archive/refs/heads/main.zip

# Basic file check
ls -la *.lua

# Count lines in core files (total: ~263 lines)
wc -l *.lua

# Find FiveM-specific functions (should find ~10 matches)
grep -n "RegisterNetEvent\|TriggerEvent\|Citizen\." *.lua

# Validate manifest exists and is readable
test -f fxmanifest.lua && echo "✓ Manifest exists" || echo "✗ Manifest missing"

# Quick syntax validation for all Lua files
for f in *.lua; do echo "Checking $f..."; python3 -c "
import re
with open('$f', 'r') as file:
    content = file.read()
    if 'function' in content: print('✓ Contains functions')
    if 'RegisterNetEvent' in content or 'TriggerEvent' in content: print('✓ FiveM script')
"; done
```

Always remember: This resource creates an immersive Chicago Bridgeport neighborhood experience in GTA V through FiveM with dynamic NPCs, realistic day/night cycles, and interactive robbery mechanics.