pipeline{

    agent any

    options{

        buildDiscarder(logRotator(numToKeepStr: '5', daysToKeepStr: '5'))
        timestamps()
    }

    environment{
        
        image_built=''
        image_tag='riya/capstone:${GIT_COMMIT}-build-${BUILD_NUMBER}'
        
    }

    tools{

        nodejs 'node'
        jdk 'jdk'
    }

    stages{
        
        stage("Install NPM modules")
        {
            steps
            {
                sh 'npm install'
            }
        }

        stage("Build")
        {
            steps
            {
                sh 'npm run-script build'
                sh 'docker-compose up'
            }
        }

        stage("Test")
        {
            when
            {
                branch 'Testing'   
            }
            steps
            {
                sh 'npm test'          
            }
        }

        