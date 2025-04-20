pipeline {
    agent any
    
    options {
        timeout(time: 30, unit: 'Minutes')
    }

    environment{
        GIT_CREDENTIALS = credentials('DevSecOps-Project')
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                // Configure Git to use a credentials file for Git
                withCredentials([usernamePassword(credentialsId: 'DevSecOps-Project', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                    sh '''
                        # Set up a Git credentials file in the workspace
                        git config credential.helper "store --file=.git-credentials"
                        
                        # Write the credentials for GitHub to the credentials file.
                        echo "https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/avishj/CMU-DevOps-Project" > .git-credentials
                        
                        # Now pull Git files using the stored credentials
                        git pull
                   '''
                }
            }
        }
    }
}
