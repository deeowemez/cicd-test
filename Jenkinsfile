pipeline {
    agent {
        docker {
            image 'node:18'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/deeowemez/cicd-test.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }

        stage('Push to Repository') {
            when {
                branch 'main'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-credentials', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                    sh '''
                    git config --global user.email "53809101+deeowemez@users.noreply.github.com"
                    git config --global user.name "aian"
                    git remote set-url origin https://$GIT_USER:$GIT_PASS@github.com/deeowemez/cicd-test.git
                    git push origin main
                    '''
                }
            }
        }
    }
}
