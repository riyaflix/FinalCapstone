pipeline
{

    agent any

    options
    {

        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: '5'))
        timestamps()
    }

    environment
    {
        
        dockerhubRepository = "riyaflix/notesapp"
        dockerhubCredentials = 'DockerhubCredentials'
        dockerImage = ''
    }

    tools
    {

        nodejs 'node'
        jdk 'jdk11'
    }

    stages
    {
        
        stage("Building, Pushing and Deploying")
        {
            when
            {
                branch 'main'
            }
            stages
            {
                stage("Building Docker Image")
                {
                    steps
                    {
                        script
                        {
                            dockerImage = docker.build dockerhubRepository + ":$GIT_COMMIT-build-$BUILD_NUMBER"

                        }
                    }
                }

                stage("Pushing the Docker Image")
                {
                    steps
                    {
                        script
                        {
                            docker.withRegistry('', dockerhubCredentials)
                            {
                                dockerImage.push()
                                dockerImage.push('latest')
                                dockerImage.push('v1')
                            }
                        }
                    }
                }
                stage("Deploying")
                {
                    steps
                    {
                        withKubeConfig([credentialsId: 'kubeconfig'])
                        {
                            sh 'pwd && ls'
                            sh 'kubectl apply -f kubernetes/database/mongo.yml'
                            sh 'kubectl apply -f kubernetes/app/app.yml'
                            sh 'kubectl apply -f kubernetes/app/nodeport.yml'
                        }
                    }
                }
            }
        }
    }
}
            