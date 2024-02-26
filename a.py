import os
import xml.etree.ElementTree as ET

def generate_override_bp(project_name, repo_path):
    override_content = f"""\
override_prebuilt_shared_library {{
    name: "{project_name}",
    base: "Android.bp",
    installable: false,
    check_timestamps: true,
}}
"""
    # Determine the directory for the override .bp file
    override_dir = os.path.join(repo_path, "prebuilts_override")
    os.makedirs(override_dir, exist_ok=True)

    # Wrsite the override .bp file
    bp_path = os.path.join(override_dir, "Android.override.bp")
    with open(bp_path, 'w') as f:
        f.write(override_content)

    print(f"Generated {bp_path}")

def parse_manifest(manifest_path):
    tree = ET.parse(manifest_path)
    root = tree.getroot()
    projects = []
    for child in root:
        if child.tag == 'project':
            project_name = child.attrib['name']
            repo_path = child.attrib['path']
            projects.append((project_name, repo_path))
    return projects

def main():
    manifest_path = '.repo/manifest.xml'  # Adjust this path

    projects = parse_manifest(manifest_path)

    for project_name, repo_path in projects:
        generate_override_bp(project_name, repo_path)

if __name__ == "__main__":
    main()