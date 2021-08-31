pipeline {
    agent any
    //tools {maven "maven"}

    stages {
      
      stage('Maven Build') {
        steps {
          sh '''
          ./mvnw clean
          ./mvnw install
          '''     
        }
      } 

      stage ('Renaming the Artifact Version') {
            steps {
                dir('target') {
                sh '''
                filename=`echo *.jar | awk -F '.jar' '{print $1}'`
                export fileout="${filename}-${BUILD_NUMBER}.jar"
                mv *.jar $fileout
                '''
                script {
                    env.Artifact_ID = sh(script: 'ls *.jar', returnStdout: true).trim()
                    
                    }
                }

            }
        }

      stage ('Upload file') {
            steps {
                
                rtUpload (
                    serverId: "artifactory-server",
                    spec: """{
                            "files": [
                                    {
                                        "pattern": "target/*.jar",
                                        "target": "Spring-Petclinic-Rest-Local"
                                    }
                                ]
                            }"""
                )
            }
        }

        }

     post { 
        success { 
            echo 'Job is success and triggering another pipeline'
            echo "Artifact id is : $env.Artifact_ID"
            build job: 'practical-nomad-consul' ,parameters: [string(name: 'ARTIFACT_REST', value: "$env.Artifact_ID")]
        }
    }

}