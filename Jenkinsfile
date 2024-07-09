pipeline {
    agent {
        node {
            label 'aosp-builder'
        }
    }
    stages {
        stage('Sync'){
            steps {
                sh 'chmod +x atomsync.sh && bash atomsync.sh'
            }
        }
        stage('BuildAllVariants') {
            matrix {
                agent {
                    node {
                        label 'aosp-builder'
                    }
                }
                environment {
                    TG_TOKEN     = credentials('ppd_bot_token')
                    CHAT_ID = credentials('puhq_chat_id')
                }
                axes {
                    axis {
                        name 'VARIANT'
                        values 'gapps', 'microg', 'vanilla'
                    }
                }
                stages {
                    stage("Building One Variant") {
                        steps {
                            echo "Building BlissROM for ${VARIANT}"
                            sh 'chmod +x ./build.sh'
                            sh "./build.sh ${VARIANT}"
                        }
                    }
                }
            }     
        }
    }
}