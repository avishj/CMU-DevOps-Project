#!/bin/bash

# This script orchestrates the execution of the entire project.

# STAGE 1: Using Terraform to create the infrastructure including both the VMs (Pipeline Server + Application Server).

# STAGE 2: Setting up the Pipeline Server with pipeline-orchestrator.sh. Waiting for the pipeline server to be up and running before proceeding to the next stage.

# STAGE 3: Setting up the Application Server with application-orchestrator.sh. It also deploys the application. Waiting for the application server to be up and running before proceeding to the next stage.

# STAGE 4: Starting the test with test-orchestrator.sh. It will run the test.