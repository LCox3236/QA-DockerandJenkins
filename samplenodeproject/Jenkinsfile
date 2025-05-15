pipeline {
    agent any
    stages {
        stage('Build'){
        steps{
            sh 'cd samplenodeproject && docker build -t nodeapp .'
        }
      }
    }
}
