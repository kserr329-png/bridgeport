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
