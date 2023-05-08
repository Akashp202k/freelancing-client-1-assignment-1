# freelancing-client-1-assignment-1

* Deploy WordPress with MySQL(aws RDS) with Terraform on AWS
    
    • Need to create a RDS instance with mysql needs to be connected to wordpress
    • Need to create a EC2 instance and install wordpress using latest docker image, for database connection, use the above RDS mysql instance   
    • Deployed Wordpress site needs to be accessible by public IP of the above EC2 instance.
    
Note:-
    • Above all the process needs to be automated by the terraform script. t2.micro instance will be fine 
    • docker-compose can be used for provisioning the container inside EC2, or through docker run command, also a bastion host can be used for provisioning the wordpress installation.
    • EC2 instance needs to be accessed through SSH via public IP through a pem key, this key needs to be exported by terraform. Port 80 and 22 needs to open on this instance.
    • Security group needs to be created according to each service.

After completing the deployment. Share us the terraform source in zip and provide the public IP of ec2 instance and pem file that was exported during the terraform deployment which can be used to login to the ec2 instance.
