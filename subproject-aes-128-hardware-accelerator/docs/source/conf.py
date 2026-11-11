# docs/source/conf.py
# Configuration file for the Sphinx documentation builder

# Project Information
project = 'Subproject: AES-128 Hardware Accelerator'
author = 'Alfonso Castillo Orozco'
release = '0.1'

# General Configuration
extensions = [
    'sphinx-rtd-theme',         # Read the Docs Theme for Sphinx Documentation
    'sphinx_needs',             # Sphinx Requirements Traceability Extension. reST Native Support for Documentation
    'sphinxcontrib-plantuml',   # Sphinx PlantUML Integration
    'myst_parser'               # Markdown Support for Documentation
]

templates_path = ['_templates'] # Optional: Custom templates for Sphinx documentation
exclude_patterns = [            # Optional: Exclude specific files or directories from documentation        
    '_build',
    '_includes/*'    
]

# Sphinx Needs Configuration - Requirements Traceability Extension
needs_from_toml = "ubproject.toml"  # Load configuration from external TOML file

# HTML Output Options
html_theme = 'sphinx_rtd_theme'         # Read the Docs Theme
html_static_path = ['_static']          # Optional: Additional static files (e.g. CSS)
html_css_files = ['css/custom.css']     # Optional: Additional CSS files to include in the HTML output, to customize main theme style
