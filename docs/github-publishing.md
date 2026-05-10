# GitHub Publishing Guide

## Goal

Publish the project as a clean and realistic research prototype repository.

## Suggested Repository Name

Recommended names:

- runtime-aware-sdn-te-lab
- sdn-ebpf-te-lab
- ebpf-sdn-traffic-engineering-lab

Recommended final choice:

runtime-aware-sdn-te-lab

## Before Publishing

Run:

git status

Run repository hygiene check:

./scripts/maintenance/check-repo-hygiene.sh

Run stable demo plan check if available:

./scripts/demo/check-stable-demo-plan.sh

Check that no secrets are committed:

- SSH private keys
- API tokens
- passwords
- vault files
- environment files
- large logs
- generated binary artifacts

## Create GitHub Repository

Option 1: GitHub UI

1. Go to GitHub.
2. Create a new repository.
3. Name it runtime-aware-sdn-te-lab.
4. Do not initialize with README.
5. Copy the remote SSH URL.

Then run:

git remote add origin git@github.com:vitalvirtue/runtime-aware-sdn-te-lab.git
git push -u origin main

Option 2: GitHub CLI

If gh is installed:

gh repo create vitalvirtue/runtime-aware-sdn-te-lab --private --source=. --remote=origin --push

Later, it can be made public when documentation is ready.

## Recommended First Release State

Before making public:

- README is complete
- architecture documentation exists
- test matrix exists
- stable demo guide exists
- known limitations are clearly written
- secrets and logs are not included
