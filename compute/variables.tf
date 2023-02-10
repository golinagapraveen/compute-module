variable "pub_sb_001_id" {}
variable "ext_sb_003_id" {}
variable "ext_sb_013_id" {}
variable "trust_sb_005_id" {}
variable "lm_sg_ad_client_id" {}
variable "lm_sg_eks_control_plane_id" {}
variable "lm_sg_eks_worker_nodes_id" {}
variable "lm_sg_kubectl_worker_nodes_id" {}
variable "lm_sg_priv_jump_src_id" {}
variable "lm_sg_priv_jump_dest_id" {}
variable "lm_sg_linux_priv_jump_src_id" {}
variable "lm_sg_linux_priv_jump_dest_id" {}
variable "lm_sg_internet_clients_id" {}
variable "lm_sg_privatelink_dynamodb_id" {}
variable "lm_sg_privatelink_s3_id" {}
variable "lm_sg_ad_ses_id" {}
variable "lm_sg_kibana_domain_client_security_group_id" {}
variable "lm_sg_external_proxy_security_group_id" {}
variable "lm_sg_priv_vdi_dest_id" {}
variable "trust_sb_015_id" {}



variable "kubectl_ec2_name" {}
variable "eks_ami" {}
variable "kubectl_ami" {}
variable "certbot_ami" {}
variable "jenkins_proxy_ami" {}
variable "eks_worker_instance_type" {}
variable "eks_asg_min" {}
variable "eks_asg_max" {}
variable "eks_asg_desired" {}

variable "aws_build_account_id" {}
variable "aws_target_account_id" {}
variable "jump_ami" {}
variable "jump_count" {}
variable "linux_jump_ami" {}
variable "worker_instance_profile" {}
variable "kubectl_instance_profile" {}
variable "worker_role_arn" {}
variable "kubectl_role_arn" {}
variable "ssm_connect_instance_profile" {}
variable "lm_deny_session_manager_instance_profile" {}
variable "lm_eks_kms_arn" {}
variable "lm_ec2_public_key" {}
variable "lm_eks_iam_role_arn" {}
variable "lm_domain_name" {}
variable "velero_version" {}
variable "addon_cni_version" {}
variable "k8s_ingress_http_target_group_arn" {}
variable "k8s_ingress_https_target_group_arn" {}
variable "lm_sg_linux_priv_logcollctor_dest_id" {}
variable "lm_sg_windows_priv_logcollctor_dest_id" {}
variable "lm_sg_ad_log_collector_id" {}
variable "sns_topic_arn" {}
variable "lm-sg-ad-client_shared_account_id" {}
variable "lm-sg-ad-client_lnx_shared_account_id" {}
variable "target_rsys" {}
variable "lm-sg-windows-cyberark-connectivity-dest_id" {}
variable "lm-sg-linux-cyberark-connectivity-dest_id" {}


##subnets to deploy eks cluster in it
variable "subnet1" {}
variable "subnet2" {}
variable "eks_cluster_name" {}
variable "env_id" {}
variable "eks_version" {}
variable "region" {}
