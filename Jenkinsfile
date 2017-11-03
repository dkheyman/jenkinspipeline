pipeline {
  agent any

  tools {
    maven 'localMaven'
    git 'localGit'
  }

  triggers {
    pollSCM('* * * * *')
  }

  stages{
    stage('Maven Build'){
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Build'){
      parallel {
        stage ('Building Development') {
          environment {
            ENV = 'dev'
            GIT_TAG = sh (script: 'git log -1 --pretty=%h', returnStdout: true)
          }
          steps {
            sh 'tree'
            sh 'whoami'
            sh 'systemctl status docker'
            sh 'docker build . -t dkheyman/trial-repo:$GIT_TAG -t dkheyman/trial-repo:$ENV'
            sh 'docker push dkheyman/trial-repo:$GIT_TAG'
            sh 'docker push dkheyman/trial-repo:$ENV'
          }
          post {
            success {
              echo 'Successfully built docker dev image'
            }
          }
        }
        stage ('Building Production') {
          environment {
            ENV = 'prod'
            GIT_TAG = sh (script: 'git log -1 --pretty=%h', returnStdout: true)
          }
          steps {
            sh 'docker build . -t dkheyman/trial-repo:$GIT_TAG -t dkheyman/trial-repo:$ENV'
            sh 'docker push dkheyman/trial-repo:$GIT_TAG'
            sh 'docker push dkheyman/trial-repo:$ENV'
          }
          post {
            success {
              echo 'Successfully built docker prod image'
            }
          }
        }
      }
    }

    stage ('Deployments'){
      parallel{
        stage ('Deploy to Development'){
          steps {
            sh "cat init.sh | ssh ec2-user@20.0.3.200 -i /var/lib/jenkins/.ssh/ec2 'bash -ex' "
          }
        }

        stage ("Deploy to Production"){
          steps {
            sh "cat init.sh | ssh ec2-user@20.0.3.128 -i /var/lib/jenkins/.ssh/ec2 'bash -ex' "
          }
        }
      }
    }
  }
}
