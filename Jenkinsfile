pipeline {
  agent any
  stages {
    stage('Initialization') {
      steps {
        script{
          sh 'mkdir ${GOPATH}/src/grouter'
          sh 'cp * ${GOPATH}/src/grouter -R'
          sh 'cd ${GOPATH}/src/grouter'
          checkout scm
        }
      }
    }
    stage('Dependencies') {
      steps {
        script{
            sh ' cd ${GOPATH}/src/grouter && dep ensure'
          }
      }
    }
    stage('Tests') {
      steps {
        script {
          sh 'cd ${GOPATH}/src/grouter/ && go test -v'
        }
      }
    }
  }
  post {
    always{
      sh 'cd ../'
      sh "rm -R ${GOPATH}/src/grouter"
    }
  }
}
