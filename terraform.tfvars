aws_region = "us-east-2"
cluster_name = "entana-stage"
publicly_accessible = true
# cluster_arn= "arn:aws:ecs:us-east-1:597544333513:cluster/bhub-frontend-dev" 
# log_name = "poc_log"
function_name = "lambda-func"
file_handler = "hello-python.lambda_handler"
lambda_bucket = "lambdaaaaabuckkkeettt"
memory_size = 512
runtime = "python3.8"
load_balancer_name = "lambda1-lb"
target_group_name = "lambda1-tg"
timeout = 3
envs = {
     test = "success"
     testt = "fail"
  }   

containers={

    container1={

        # cluster_name = "bhub-frontend-dev"
        ecs_desired_count = 1
        image_name = "httpd"
        container_name = "342214740201.dkr.ecr.us-east-1.amazonaws.com/entana_backend_rest" 
        ecs_service_name = "entana-backend-service"
        # container_definition_file = "container_definations.json"
        alb_name = "entana-backend-alb"
        internal = true
         /* cert_arn = "arn:aws:acm:us-east-1:727085843824:certificate/f90c85e2-8f15-4edf-a01e-f29724f5c0fc"  */
        /* repository_name = "entana-backend" */
        
        container_port=80
        # cluster_count=true
        # family_name = "poc-frontend-dev"
        envs = [ 
          {name: "PORT" , value: "4000"},
          {name: "NODE_ENV" , value: "development"},
          {name: "DATABASE_NAME" , value: "entanadb"},
          {name: "DATABASE_HOST" , value: "34.229.173.72"},
          {name: "DATABASE_PORT" , value: "5432"},
          {name: "DATABASE_USER" , value: "entana"},
          {name: "DATABASE_PASSWORD" , value: "entana"},
          {name: "JWT_SECRET" , value: "shh"},
          {name: "FRONTEND_URL" , value: "https://dev.entana.net"},
          {name: "SOCKET_URL" , value: "https://sockettemp.entana.net"},
          {name: "MAIL_HOST" , value: "smtp.sendgrid.net"},
          {name: "MAIL_PORT" , value: "587"},
          {name: "MAIL_USERNAME" , value: "apikey"},
          {name: "MAIL_PASSWORD" , value: "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"},
          {name: "MAIL_FROM_ADDRESS" , value: "donotreply@entana.net"}
          ]

     }
     container2={

        # cluster_name = "bhub-frontend-dev"
        ecs_desired_count = 1
        image_name = "nginx"
        container_name = "342214740201.dkr.ecr.us-east-1.amazonaws.com/entana_grapgql_dev_app" 
        ecs_service_name = "entana-graphql-service"
      #  container_definition_file = "container_definations.json"
        alb_name = "entana-graphql-alb"
        internal = false
        /* cert_arn = "arn:aws:acm:us-east-1:727085843824:certificate/f90c85e2-8f15-4edf-a01e-f29724f5c0fc"  */
        /* repository_name = "graphql" */
        
        container_port=80
        # cluster_count=false
        # family_name = "poc-frontend-dev"
        envs = [ 
          {name: "PORT" , value: "3030"},
          {name: "NODE_ENV=" , value: "development"},
          {name: "DATABASE_NAME" , value: "postgres"},
          {name: "DATABASE_HOST" , value: "entanadb.cblpzaiabz2u.us-east-1.rds.amazonaws.com"},
          {name: "DATABASE_PORT" , value: "5432"},
          {name: "DATABASE_USER" , value: "entanadb"},
          {name: "DATABASE_PASSWORD" , value: "entanadb"},
          {name: "JWT_SECRET" , value: "shh"},
          {name: "REST_URL" , value: "https://dev-rest.entana.net"},
          ]
     }
   
    
}   