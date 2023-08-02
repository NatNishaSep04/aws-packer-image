packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learning-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "us-east-2" #Ohio
  source_ami    = "ami-097a2df4ac947655f"
  ssh_username = "ubuntu"
}

build {
  name = "learning-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    inline = [
      "sleep 30",
      "sudo su",
      "cd",
      "sudo apt-get update && sudo apt-get upgrade -y",
      "sudo apt-get install libtomcat9-java -y",
      "sudo apt-get update -y",
      "sudo apt-get install tomcat9-admin tomcat9-common -y",
      "sudo apt-get install tomcat9 -y",
      "cd /var/lib/tomcat9/webapps/",
      "sudo wget https://artifact-storage-myapp.s3.us-east-2.amazonaws.com/myapp.war",
      "sudo systemctl start tomcat9"
    ]
  }
}

# To test ||!!!