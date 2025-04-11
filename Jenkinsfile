pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git 'https://your-repo-url'
      }
    }
    stage('Create Topics') {
      steps {
        sh 'chmod +x create-topics.sh'
        sh './create-topics.sh'
      }
    }
  }
}
