pipeline {
    agent any

    tools {
      maven 'localMaven'
      git 'localGit'
    }

    parameters {
         string(name: 'tomcat_dev', defaultValue: '34.213.8.165', description: 'Staging Server')
         string(name: 'tomcat_prod', defaultValue: '52.27.158.97', description: 'Production Server')
    }

    triggers {
         pollSCM('* * * * *')
     }

stages{
        stage('Build'){
            steps {
                sh 'mvn clean package'
            }
            post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }

        stage ('Deployments'){
            parallel{
                stage ('Deploy to Staging'){
                    steps {
                        sh "cat init.sh | ssh ec2-user@${params.tomcat_dev} -i /Users/Shared/Jenkins/Home/david-docker.pem 'bash -ex' "
                    }
                }

                stage ("Deploy to Production"){
                    steps {
                        sh "cat init.sh | ssh ec2-user@${params.tomcat_prod} -i /Users/Shared/Jenkins/Home/david-docker.pem 'bash -ex' "
                    }
                }
            }
        }
    }
}
