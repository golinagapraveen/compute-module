pipeline {
  agent any

  options {
    buildDiscarder(logRotator(numToKeepStr:'30'))
    timeout(time: 1, unit: 'HOURS')
    ansiColor('xterm')
  }

  parameters {
    /*
       The list of environments in the parameter below should be changed to suit your module, the values set are used for Runtime terraform modules.
       If you are creating a terraform module that is deployed once per account simply replace the values with the relevant account names, e.g. noc201, noc101, noc001
       PLEASE NOTE: The values you set in the ENV parameter section need to have the same names as the tfvars files in the env directory e.g. noc201.tfvars should exist if you are targetting that account.
    */
    choice(name: 'ENV', choices: ['noc201'], description:'Environment to deploy to')
  }

  environment {
    GIT_REPO_NAME = env.GIT_URL.replaceFirst(/^.*\/([^\/]+?).git$/, '$1') // Gets the repo name from github url to query dynamodb
  }

  stages {
    stage("Set Env Vars"){
      steps {
        script{
          withCredentials ([usernamePassword(credentialsId: 'use-this', usernameVariable: 'TF_AK', passwordVariable: 'TF_SK')]){
            env.AWS_ACCESS_KEY_ID = "${TF_AK}"
            env.AWS_SECRET_ACCESS_KEY = "${TF_SK}"
            env.AWS_DEFAULT_REGION="eu-west-1"
            env.DYNAMO_VARS = sh(returnStdout: true, script: """aws dynamodb --region eu-west-2 get-item --table-name lm-terraform-jenkins-params --key '{"module": {"S": "${GIT_REPO_NAME}"}, "environment": {"S": "${ENV}"}}'| jq '.Item'""")
            env.DYNAMODB_TABLE = sh(returnStdout: true, script: '''echo ${DYNAMO_VARS} | jq -r ".dynamodb_table[]"''').trim()
            env.TF_S3_BUCKET = sh(returnStdout: true, script: '''echo ${DYNAMO_VARS} | jq -r ".tf_s3_bucket[]"''').trim()
            env.TF_STATE_LOC = sh(returnStdout: true, script: '''echo ${DYNAMO_VARS} | jq -r ".tf_state_loc[]"''').trim()
            env.TF_CREDS_NAME = sh(returnStdout: true, script: '''echo ${DYNAMO_VARS} | jq -r ".tf_creds_name[]"''').trim()
          } // end withCredentials
        } // end script
      } // end steps
    } // end stage
    
    stage('Terraform Plan') {
      steps {
        container('slave-terraform') {
          script {
            withCredentials ([usernamePassword(credentialsId: env.TF_CREDS_NAME, usernameVariable: 'TF_AK', passwordVariable: 'TF_SK')]){
              env.AWS_ACCESS_KEY_ID = "${TF_AK}"
              env.AWS_SECRET_ACCESS_KEY = "${TF_SK}"
              env.TARGET_ACCOUNT_ID = sh(returnStdout: true, script: '''aws sts get-caller-identity | jq -r .Account''').trim()
              env.TARGET_ACCOUNT_ALIAS = sh(returnStdout: true, script: '''aws iam list-account-aliases | jq -r .AccountAliases[]''').trim()
              sh '''
                terraform init -backend=true -backend-config="bucket=${TF_S3_BUCKET}" -backend-config="key=${TF_STATE_LOC}" -backend-config="dynamodb_table=${DYNAMODB_TABLE}"
                terraform plan -var-file="env/${ENV}.tfvars" -out tfplan
                
                set +x
                echo ""
                echo "####################"
                echo "#    PLEASE NOTE   #"
                echo "####################"
                echo ""
                echo "These changes above will be applied to the AWS Account with the ID of: ${TARGET_ACCOUNT_ID} and the alias of ${TARGET_ACCOUNT_ALIAS} based on the credentials provided"
                echo "Please ensure only the changes you are expecting are showing in the plan output and the account they are being deployed to is correct before proceeding"
                echo ""
              '''
            } // end withCredentials
          } // end script
        }  // end container
      }  // end steps
    }   // end stage

    stage('Apply Approval') {
      steps {
          input "Apply these changes to ${ENV} in AWS Account with the alias: ${TARGET_ACCOUNT_ALIAS}?"
      } //end steps
    } // end stage

    stage('Terraform Apply') {
      steps {
        container('slave-terraform') {
          script {
            sh '''
              terraform apply -auto-approve tfplan
            '''
         } // end script
        }// end container
      } // end steps
    } // end stage
  }   //  end stages
}  // end pipeline