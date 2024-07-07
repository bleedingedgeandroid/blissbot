pipeline {
    agent none
    stages {
        stage('Sync'){
            sh 'chmod +x atomsync.sh && bash atomsync.sh'
        }
        stage('Build') {
            matrix {
                agent {
                    node {
                        label 'aosp-builder'
                    }
                }
                axes {
                    axis {
                        name 'VARIANT'
                        values 'foss', 'gapps', 'microg', 'vanilla'
                    }
                }
                stages {
                    stage('Build ${VARIANT}') {
                        steps {
                            echo "Building BlissROM for ${VARIANT}"
                            sh 'chmod +x ./build.sh'
                            sh './build.sh ${VARIANT}'
                        }
                    }
                }

                post {
                    always {
                        archiveArtifacts artifacts: '*.zip', fingerprint: true
                    }
                }
            }
        }
    }

}