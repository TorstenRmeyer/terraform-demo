node {
	
	stage("startup") {
		//Remove later.... sho that Jenkinsfile works
		echo "start build"
		env.PATH = "/usr/local/bin/:${env.PATH}"
		//Terraform version print
		sh "terraform --version -no-color"
	}
	stage("prepare") {
		
			//Checkout current project .. other can be checked out using git
			checkout scm
		
			//setup local environment with terraform init and set remote config
			// terraform init is safe to run multiple times
			// Open: Use a different key-pair to get state
			sh "terraform init -no-color -backend=true -backend-config \"bucket=terraform-state-demotenant\" -backend-config \"key=${env.JOB_NAME}\" -backend-config \"region=eu-central-1\""
			
			//set AWS Credentials - credentials need to be in Jenkins credentials using a naming schema
			withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'demo-tenant', usernameVariable : 'USERNAME', passwordVariable : 'PASSWORD']]) {
				env.AWS_SECRET_KEY_ID = "$USERNAME"
				env.AWS_SECRET_ACCESS_KEY = "$PASSWORD"
			}
	}
	stage("plan") {
		//Run terraform plan to see what will change
		// OPTIONAL set vars using --var-file=[JOB_NAME].tfvars
		sh "terraform plan -no-color -out-file=plan.out"
	}
	stage("apply") {
		//Run terraform plan to see what will change
		sh "terraform apply plan.out -no-color"
		
		//Write result somewhere
	}
}
