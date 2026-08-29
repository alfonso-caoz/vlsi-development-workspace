# Project Management Notes

This section describes the followed `Project: VLSI Development Workspace` management process based on **Agile/Scrum Development**, where each subproject is a milestone:

- [Project Management Process: VLSI Development Workspace](https://github.com/users/alfonso-caoz/projects/4)

## Project Folder Structure

This is the current project folder structure:

```bash
vlsi-development-workspace/
├── .github/
│   ├── ISSUE_TEMPLATE/               # Folder with Issue templates
│   ├── PULL_REQUEST_TEMPLATE/        # Folder with PR templates
│   ├── rulesets/                     # Reference: Folder with rulesets
│   └── labels.yaml                   # Reference: Project labels
├── docs/                             # Folder with Project Management documents
├── subproject-asic-design-pipeline/  # Subproject: ASIC Design Pipeline
├── CHANGELOG.md
└── README.md
```

### Branches

This repository will have one `main` branch. When an Issue requires new repository additions, a branch will be created from `main` following the **branch name format** depending of the Issue type: 

- \[FEAT\]: `feat/<issue-number>-<issue-name-lowercase>`
- \[BUG\]: `fix/<issue-number>-<issue-name-lowercase>`
- \[DOCS\]: `docs/<issue-number>-<issue-name-lowercase>`
- \[CONFIG\]: `config/<issue-number>-<issue-name-lowercase>`

**Example**: Issue [\[CONFIG\] Project Repository Initial Setup #1](https://github.com/alfonso-caoz/vlsi-development-workspace/issues/1), use the branch name `config/1-project-repository-initial-setup`. 

Terminal commands to clone the repository and create new branches:

```bash
# Install git if missing and not configured, e.g. with APT
sudo apt update && sudo apt install git
git config --global user.name "Your Name In Repository"
git config --global user.email "your_email_in_repository@example.com"

# Clone locally the repository
git clone https://github.com/alfonso-caoz/vlsi-development-workspace.git
cd vlsi-development-workspace

# Make sure the main branch is updated
git checkout main
git pull

# Create a new local branch from main AND push it to remote
git checkout -b <branch-name-convention>
git push -u origin <branch-name-convention>
```
#### Considerations
- For exclusively `Subprojects` changes use \[FEAT\], \[BUG\], and \[DOCS\] Issues.
- \[PLAN\], \[EPIC X\], and \[SPRINT X\] Issues are not normally meant to create a new branch to be merged to `main`.
- If a \[PLAN\] or \[SPRINT X\] Issue requires just documentation changes in the repository, you can create the branch for that issue as `docs/<issue-number>-<issue-name-lowercase>`.
- If a \[PLAN\] Issue will require changes in the repository, please use the Issue type \[CONFIG\] for the issue creation, instead. Then, follow the \[CONFIG\] branch name convention.

> [!IMPORTANT]
> All changes require a reviewed PR to be merged to `main` branch, using the PR title as the last `squash and merge` commit (see [Pull Request (PR) Title Convention](#pull-request-pr-title-convention) section).

## GitHub Repository Configuration

### General Settings

As Administrator, from repository in GitHub Web UI `vlsi-development-workspace/Settings/General`, check the following settings:

**General**

**Default branch**
- [x] `Default branch`: main

**Features**
- [x] `Issues` + `Issues permissions`: Collaborators only
- [x] `Projects`
- [x] `Pull requests` + `Pull request permissions`: Collaborators only

**Pull Requests**
- [x] `Allow merge commits` + `Default commit message`: Pull request title
- [x] `Allow squash merging` + `Default commit message`: Pull request title
- [x] `Allow rebase merging`
- [x] Always suggest updating pull request branches
- [x] Automatically delete head branches

**Commits**
- [x] Allow comments on individual commits

**Issues**
- [x] Auto-close issues with merged linked pull requests

**Danger Zone**
- [x] `Change repository visibility`: Public

> [!NOTE]
> The rest of options were left empty, activate them if required during the project.

### Rulesets

As Administrator, from repository in GitHub Web UI `vlsi-development-workspace/Settings/Rules/Rulesets`, import the following JSON ruleset file for the `main` branch (considering this is a personal repository, so requesting reviewers will block merging PR's):

- [main-branch-protection-ruleset.json](./../.github/rulesets/main-branch-protection-ruleset.json)

> [!TIP]
> Check the GitHub documentation for [Importing prebuilt rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/creating-rulesets-for-a-repository#importing-prebuilt-rulesets), with examples in repository [github/ruleset-recipes](https://github.com/github/ruleset-recipes).

> [!NOTE]
> Ruleset JSON files have to be loaded through GitHub Web UI to be applied successfully, it is not enough as files within [.github](./../.github) folder. Even though, this one was included in the repository folder [.github/rulesets](./../.github/rulesets/) for future reference.

### Labels

The required labels to manage this project were manually added through the GitHub Web UI. As this was a one-time task, it was not required to automate it with a bash script. Here is the YAML file with the labels' information as reference:

- [labels.yaml](./../.github/labels.yaml)

> [!NOTE]
> Having a label YAML file within [.github](./../.github) folder is not going to work, they have to be configure through GitHub Web UI to be applied successfully; or with YAML files plus third-party tools. Even though, this one was included in the repository folder [.github](./../.github) for future reference.

## Templates

### Issue Templates

The following Issue templates were created:

- [Management Issue Template - \[PLAN\]](./../.github/ISSUE_TEMPLATE/management-issue-template.yaml): Plan milestones, track epics, or request administrative project changes.
- [Configuration Issue Template - \[CONFIG\]](./../.github/ISSUE_TEMPLATE/configuration-issue-template.yaml): Request or modify system configurations, CI/CD pipelines, or environment variables.
- [Epic Issue Template - \[EPIC X\]](./../.github/ISSUE_TEMPLATE/epic-issue-template.yaml): Track a large-scale initiative or user story/issue collection.
- [Feature Issue Template - \[FEAT\]](./../.github/ISSUE_TEMPLATE/feature-issue-template.yaml): Propose a new idea or enhancement. Just for `Subproject` scope.
- [Bug Issue Template](./../.github/ISSUE_TEMPLATE/bug-issue-template.yaml): File a report for broken functionality. Just for `Subproject` scope.
- [Documentation Issue Template - \[DOCS\]](./../.github/ISSUE_TEMPLATE/documentation-issue-template.yaml): Report missing info, correct typos, or suggest a new guide/README expansion.
- [Sprint Summary and Retrospective Issue Template - \[SPRINT X\]](./../.github/ISSUE_TEMPLATE/sprint-summary-issue-template.yaml): Plan, track subproject tasks, and log metrics for a specific sprint.

This configuration Issue file was added to avoid creating a blank issue, forcing to use the previously mentioned templates:

- [Configuration Issue File](./../.github/ISSUE_TEMPLATE/config.yaml)

#### How to use the Issue Templates in GitHub?

When creating an issue, go to the Issue tab from the repository GitHub Web UI. Click on `New issue`, and `Get started` next to the selected template from a list, fill it out, and finally click on `Submit new issue`. 

### Pull Request (PR) Templates

The following PR templates were created (see also [Branches](#branches) section):

- [Configuration PR Template](./../.github/PULL_REQUEST_TEMPLATE/configuration-pr-template.md): Issue \[CONFIG\], for `Project Management` configuration.
- [Feature PR Template](./../.github/PULL_REQUEST_TEMPLATE/feature-pr-template.md): Issue \[FEAT\], just for `Subproject` scope.
- [Bug Fix PR Template](./../.github/PULL_REQUEST_TEMPLATE/bug-fix-pr-template.md): Issue \[BUG\], just for `Subproject` scope.
- [Documentation PR Template](./../.github/PULL_REQUEST_TEMPLATE/documentation-pr-template.md): Issue \[DOCS\], just for `Subproject` scope. If required Issue \[PLAN\] or \[SPRINT X\], for `Project Management` documentation.

#### How to use the Issue Templates in GitHub?

When creating a PR, from the repository GitHub Web UI. Click on `New pull request`, and append manually to the `url` the next keywords depending on the required PR scope:

- `&template=configuration-pr-template.md`
- `&template=feature-pr-template.md`
- `&template=bug-fix-pr-template.md`
- `&template=documentation-pr-template.md`

**Example**: `https://github.com/alfonso-caoz/vlsi-development-workspace/compare/docs/15-sprint-1-summary-retrospective?expand=1&template=documentation-pr-template.md` and press `Enter`, now the PR description is fill out with your template information.

> [!NOTE]
> If there is already a `?` in the url, all following commands to be appended should start with `&` (**Example Case**). If not, use `?` for the first keyword set to be appended.

#### Pull Request (PR) Title Convention

A reviewed PR will be merged to `main` branch, using the PR title as the last `squash and merge` commit. That is why it is important to follow a **PR title convention**, depending on the Issue type:

- \[FEAT\]: `feat: #<issue-number> <issue-name>`
- \[BUG\]: `fix: #<issue-number> <issue-name>`
- \[DOCS\]: `docs: #<issue-number> <issue-name>`
- \[CONFIG\]: `config: #<issue-number> <issue-name>`

## Changelog

This changelog file will be updated each time a Sprint is closed, with all tasks, metrics, and retrospective updates. It covers **high-level updates**, for more details review the respective Issue to close the Sprint (see [Board: "Sprints: Summary & Retrospective"](https://github.com/users/alfonso-caoz/projects/4/views/11)).

- [Changelog](./../CHANGELOG.md)
