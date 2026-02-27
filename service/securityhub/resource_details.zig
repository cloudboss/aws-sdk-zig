const aws = @import("aws");

const AwsAmazonMqBrokerDetails = @import("aws_amazon_mq_broker_details.zig").AwsAmazonMqBrokerDetails;
const AwsApiGatewayRestApiDetails = @import("aws_api_gateway_rest_api_details.zig").AwsApiGatewayRestApiDetails;
const AwsApiGatewayStageDetails = @import("aws_api_gateway_stage_details.zig").AwsApiGatewayStageDetails;
const AwsApiGatewayV2ApiDetails = @import("aws_api_gateway_v2_api_details.zig").AwsApiGatewayV2ApiDetails;
const AwsApiGatewayV2StageDetails = @import("aws_api_gateway_v2_stage_details.zig").AwsApiGatewayV2StageDetails;
const AwsAppSyncGraphQlApiDetails = @import("aws_app_sync_graph_ql_api_details.zig").AwsAppSyncGraphQlApiDetails;
const AwsAthenaWorkGroupDetails = @import("aws_athena_work_group_details.zig").AwsAthenaWorkGroupDetails;
const AwsAutoScalingAutoScalingGroupDetails = @import("aws_auto_scaling_auto_scaling_group_details.zig").AwsAutoScalingAutoScalingGroupDetails;
const AwsAutoScalingLaunchConfigurationDetails = @import("aws_auto_scaling_launch_configuration_details.zig").AwsAutoScalingLaunchConfigurationDetails;
const AwsBackupBackupPlanDetails = @import("aws_backup_backup_plan_details.zig").AwsBackupBackupPlanDetails;
const AwsBackupBackupVaultDetails = @import("aws_backup_backup_vault_details.zig").AwsBackupBackupVaultDetails;
const AwsBackupRecoveryPointDetails = @import("aws_backup_recovery_point_details.zig").AwsBackupRecoveryPointDetails;
const AwsCertificateManagerCertificateDetails = @import("aws_certificate_manager_certificate_details.zig").AwsCertificateManagerCertificateDetails;
const AwsCloudFormationStackDetails = @import("aws_cloud_formation_stack_details.zig").AwsCloudFormationStackDetails;
const AwsCloudFrontDistributionDetails = @import("aws_cloud_front_distribution_details.zig").AwsCloudFrontDistributionDetails;
const AwsCloudTrailTrailDetails = @import("aws_cloud_trail_trail_details.zig").AwsCloudTrailTrailDetails;
const AwsCloudWatchAlarmDetails = @import("aws_cloud_watch_alarm_details.zig").AwsCloudWatchAlarmDetails;
const AwsCodeBuildProjectDetails = @import("aws_code_build_project_details.zig").AwsCodeBuildProjectDetails;
const AwsDmsEndpointDetails = @import("aws_dms_endpoint_details.zig").AwsDmsEndpointDetails;
const AwsDmsReplicationInstanceDetails = @import("aws_dms_replication_instance_details.zig").AwsDmsReplicationInstanceDetails;
const AwsDmsReplicationTaskDetails = @import("aws_dms_replication_task_details.zig").AwsDmsReplicationTaskDetails;
const AwsDynamoDbTableDetails = @import("aws_dynamo_db_table_details.zig").AwsDynamoDbTableDetails;
const AwsEc2ClientVpnEndpointDetails = @import("aws_ec_2_client_vpn_endpoint_details.zig").AwsEc2ClientVpnEndpointDetails;
const AwsEc2EipDetails = @import("aws_ec_2_eip_details.zig").AwsEc2EipDetails;
const AwsEc2InstanceDetails = @import("aws_ec_2_instance_details.zig").AwsEc2InstanceDetails;
const AwsEc2LaunchTemplateDetails = @import("aws_ec_2_launch_template_details.zig").AwsEc2LaunchTemplateDetails;
const AwsEc2NetworkAclDetails = @import("aws_ec_2_network_acl_details.zig").AwsEc2NetworkAclDetails;
const AwsEc2NetworkInterfaceDetails = @import("aws_ec_2_network_interface_details.zig").AwsEc2NetworkInterfaceDetails;
const AwsEc2RouteTableDetails = @import("aws_ec_2_route_table_details.zig").AwsEc2RouteTableDetails;
const AwsEc2SecurityGroupDetails = @import("aws_ec_2_security_group_details.zig").AwsEc2SecurityGroupDetails;
const AwsEc2SubnetDetails = @import("aws_ec_2_subnet_details.zig").AwsEc2SubnetDetails;
const AwsEc2TransitGatewayDetails = @import("aws_ec_2_transit_gateway_details.zig").AwsEc2TransitGatewayDetails;
const AwsEc2VolumeDetails = @import("aws_ec_2_volume_details.zig").AwsEc2VolumeDetails;
const AwsEc2VpcDetails = @import("aws_ec_2_vpc_details.zig").AwsEc2VpcDetails;
const AwsEc2VpcEndpointServiceDetails = @import("aws_ec_2_vpc_endpoint_service_details.zig").AwsEc2VpcEndpointServiceDetails;
const AwsEc2VpcPeeringConnectionDetails = @import("aws_ec_2_vpc_peering_connection_details.zig").AwsEc2VpcPeeringConnectionDetails;
const AwsEc2VpnConnectionDetails = @import("aws_ec_2_vpn_connection_details.zig").AwsEc2VpnConnectionDetails;
const AwsEcrContainerImageDetails = @import("aws_ecr_container_image_details.zig").AwsEcrContainerImageDetails;
const AwsEcrRepositoryDetails = @import("aws_ecr_repository_details.zig").AwsEcrRepositoryDetails;
const AwsEcsClusterDetails = @import("aws_ecs_cluster_details.zig").AwsEcsClusterDetails;
const AwsEcsContainerDetails = @import("aws_ecs_container_details.zig").AwsEcsContainerDetails;
const AwsEcsServiceDetails = @import("aws_ecs_service_details.zig").AwsEcsServiceDetails;
const AwsEcsTaskDetails = @import("aws_ecs_task_details.zig").AwsEcsTaskDetails;
const AwsEcsTaskDefinitionDetails = @import("aws_ecs_task_definition_details.zig").AwsEcsTaskDefinitionDetails;
const AwsEfsAccessPointDetails = @import("aws_efs_access_point_details.zig").AwsEfsAccessPointDetails;
const AwsEksClusterDetails = @import("aws_eks_cluster_details.zig").AwsEksClusterDetails;
const AwsElasticBeanstalkEnvironmentDetails = @import("aws_elastic_beanstalk_environment_details.zig").AwsElasticBeanstalkEnvironmentDetails;
const AwsElasticsearchDomainDetails = @import("aws_elasticsearch_domain_details.zig").AwsElasticsearchDomainDetails;
const AwsElbLoadBalancerDetails = @import("aws_elb_load_balancer_details.zig").AwsElbLoadBalancerDetails;
const AwsElbv2LoadBalancerDetails = @import("aws_elbv_2_load_balancer_details.zig").AwsElbv2LoadBalancerDetails;
const AwsEventSchemasRegistryDetails = @import("aws_event_schemas_registry_details.zig").AwsEventSchemasRegistryDetails;
const AwsEventsEndpointDetails = @import("aws_events_endpoint_details.zig").AwsEventsEndpointDetails;
const AwsEventsEventbusDetails = @import("aws_events_eventbus_details.zig").AwsEventsEventbusDetails;
const AwsGuardDutyDetectorDetails = @import("aws_guard_duty_detector_details.zig").AwsGuardDutyDetectorDetails;
const AwsIamAccessKeyDetails = @import("aws_iam_access_key_details.zig").AwsIamAccessKeyDetails;
const AwsIamGroupDetails = @import("aws_iam_group_details.zig").AwsIamGroupDetails;
const AwsIamPolicyDetails = @import("aws_iam_policy_details.zig").AwsIamPolicyDetails;
const AwsIamRoleDetails = @import("aws_iam_role_details.zig").AwsIamRoleDetails;
const AwsIamUserDetails = @import("aws_iam_user_details.zig").AwsIamUserDetails;
const AwsKinesisStreamDetails = @import("aws_kinesis_stream_details.zig").AwsKinesisStreamDetails;
const AwsKmsKeyDetails = @import("aws_kms_key_details.zig").AwsKmsKeyDetails;
const AwsLambdaFunctionDetails = @import("aws_lambda_function_details.zig").AwsLambdaFunctionDetails;
const AwsLambdaLayerVersionDetails = @import("aws_lambda_layer_version_details.zig").AwsLambdaLayerVersionDetails;
const AwsMskClusterDetails = @import("aws_msk_cluster_details.zig").AwsMskClusterDetails;
const AwsNetworkFirewallFirewallDetails = @import("aws_network_firewall_firewall_details.zig").AwsNetworkFirewallFirewallDetails;
const AwsNetworkFirewallFirewallPolicyDetails = @import("aws_network_firewall_firewall_policy_details.zig").AwsNetworkFirewallFirewallPolicyDetails;
const AwsNetworkFirewallRuleGroupDetails = @import("aws_network_firewall_rule_group_details.zig").AwsNetworkFirewallRuleGroupDetails;
const AwsOpenSearchServiceDomainDetails = @import("aws_open_search_service_domain_details.zig").AwsOpenSearchServiceDomainDetails;
const AwsRdsDbClusterDetails = @import("aws_rds_db_cluster_details.zig").AwsRdsDbClusterDetails;
const AwsRdsDbClusterSnapshotDetails = @import("aws_rds_db_cluster_snapshot_details.zig").AwsRdsDbClusterSnapshotDetails;
const AwsRdsDbInstanceDetails = @import("aws_rds_db_instance_details.zig").AwsRdsDbInstanceDetails;
const AwsRdsDbSecurityGroupDetails = @import("aws_rds_db_security_group_details.zig").AwsRdsDbSecurityGroupDetails;
const AwsRdsDbSnapshotDetails = @import("aws_rds_db_snapshot_details.zig").AwsRdsDbSnapshotDetails;
const AwsRdsEventSubscriptionDetails = @import("aws_rds_event_subscription_details.zig").AwsRdsEventSubscriptionDetails;
const AwsRedshiftClusterDetails = @import("aws_redshift_cluster_details.zig").AwsRedshiftClusterDetails;
const AwsRoute53HostedZoneDetails = @import("aws_route_53_hosted_zone_details.zig").AwsRoute53HostedZoneDetails;
const AwsS3AccessPointDetails = @import("aws_s3_access_point_details.zig").AwsS3AccessPointDetails;
const AwsS3AccountPublicAccessBlockDetails = @import("aws_s3_account_public_access_block_details.zig").AwsS3AccountPublicAccessBlockDetails;
const AwsS3BucketDetails = @import("aws_s3_bucket_details.zig").AwsS3BucketDetails;
const AwsS3ObjectDetails = @import("aws_s3_object_details.zig").AwsS3ObjectDetails;
const AwsSageMakerNotebookInstanceDetails = @import("aws_sage_maker_notebook_instance_details.zig").AwsSageMakerNotebookInstanceDetails;
const AwsSecretsManagerSecretDetails = @import("aws_secrets_manager_secret_details.zig").AwsSecretsManagerSecretDetails;
const AwsSnsTopicDetails = @import("aws_sns_topic_details.zig").AwsSnsTopicDetails;
const AwsSqsQueueDetails = @import("aws_sqs_queue_details.zig").AwsSqsQueueDetails;
const AwsSsmPatchComplianceDetails = @import("aws_ssm_patch_compliance_details.zig").AwsSsmPatchComplianceDetails;
const AwsStepFunctionStateMachineDetails = @import("aws_step_function_state_machine_details.zig").AwsStepFunctionStateMachineDetails;
const AwsWafRateBasedRuleDetails = @import("aws_waf_rate_based_rule_details.zig").AwsWafRateBasedRuleDetails;
const AwsWafRegionalRateBasedRuleDetails = @import("aws_waf_regional_rate_based_rule_details.zig").AwsWafRegionalRateBasedRuleDetails;
const AwsWafRegionalRuleDetails = @import("aws_waf_regional_rule_details.zig").AwsWafRegionalRuleDetails;
const AwsWafRegionalRuleGroupDetails = @import("aws_waf_regional_rule_group_details.zig").AwsWafRegionalRuleGroupDetails;
const AwsWafRegionalWebAclDetails = @import("aws_waf_regional_web_acl_details.zig").AwsWafRegionalWebAclDetails;
const AwsWafRuleDetails = @import("aws_waf_rule_details.zig").AwsWafRuleDetails;
const AwsWafRuleGroupDetails = @import("aws_waf_rule_group_details.zig").AwsWafRuleGroupDetails;
const AwsWafv2RuleGroupDetails = @import("aws_wafv_2_rule_group_details.zig").AwsWafv2RuleGroupDetails;
const AwsWafv2WebAclDetails = @import("aws_wafv_2_web_acl_details.zig").AwsWafv2WebAclDetails;
const AwsWafWebAclDetails = @import("aws_waf_web_acl_details.zig").AwsWafWebAclDetails;
const AwsXrayEncryptionConfigDetails = @import("aws_xray_encryption_config_details.zig").AwsXrayEncryptionConfigDetails;
const CodeRepositoryDetails = @import("code_repository_details.zig").CodeRepositoryDetails;
const ContainerDetails = @import("container_details.zig").ContainerDetails;

/// Additional details about a resource related to a finding.
///
/// To provide the details, use the object that corresponds to the resource
/// type. For
/// example, if the resource type is `AwsEc2Instance`, then you use the
/// `AwsEc2Instance` object to provide the details.
///
/// If the type-specific object does not contain all of the fields you want to
/// populate,
/// then you use the `Other` object to populate those additional fields.
///
/// You also use the `Other` object to populate the details when the selected
/// type does not have a corresponding object.
pub const ResourceDetails = struct {
    /// Provides details about AppSync message broker. A message broker allows
    /// software applications and
    /// components to communicate using various programming languages, operating
    /// systems, and formal messaging protocols.
    aws_amazon_mq_broker: ?AwsAmazonMqBrokerDetails,

    /// Provides information about a REST API in version 1 of Amazon API Gateway.
    aws_api_gateway_rest_api: ?AwsApiGatewayRestApiDetails,

    /// Provides information about a version 1 Amazon API Gateway stage.
    aws_api_gateway_stage: ?AwsApiGatewayStageDetails,

    /// Provides information about a version 2 API in Amazon API Gateway.
    aws_api_gateway_v2_api: ?AwsApiGatewayV2ApiDetails,

    /// Provides information about a version 2 stage for Amazon API Gateway.
    aws_api_gateway_v2_stage: ?AwsApiGatewayV2StageDetails,

    /// Provides details about an AppSync Graph QL API, which lets you query
    /// multiple databases, microservices,
    /// and APIs from a single GraphQL endpoint.
    aws_app_sync_graph_ql_api: ?AwsAppSyncGraphQlApiDetails,

    /// Provides information about an Amazon Athena workgroup. A workgroup helps you
    /// separate users, teams,
    /// applications, or workloads. It also helps you set limits on data processing
    /// and track costs.
    aws_athena_work_group: ?AwsAthenaWorkGroupDetails,

    /// Details for an autoscaling group.
    aws_auto_scaling_auto_scaling_group: ?AwsAutoScalingAutoScalingGroupDetails,

    /// Provides details about a launch configuration.
    aws_auto_scaling_launch_configuration: ?AwsAutoScalingLaunchConfigurationDetails,

    /// Provides details about an Backup backup plan.
    aws_backup_backup_plan: ?AwsBackupBackupPlanDetails,

    /// Provides details about an Backup backup vault.
    aws_backup_backup_vault: ?AwsBackupBackupVaultDetails,

    /// Provides details about an Backup backup, or recovery point.
    aws_backup_recovery_point: ?AwsBackupRecoveryPointDetails,

    /// Provides details about an Certificate Manager certificate.
    aws_certificate_manager_certificate: ?AwsCertificateManagerCertificateDetails,

    /// Details about an CloudFormation stack. A stack is a collection of Amazon Web
    /// Services resources that you can manage as a single unit.
    aws_cloud_formation_stack: ?AwsCloudFormationStackDetails,

    /// Details about a CloudFront distribution.
    aws_cloud_front_distribution: ?AwsCloudFrontDistributionDetails,

    /// Provides details about a CloudTrail trail.
    aws_cloud_trail_trail: ?AwsCloudTrailTrailDetails,

    /// Details about an Amazon CloudWatch alarm. An alarm allows you to monitor and
    /// receive alerts about your Amazon Web Services resources and applications
    /// across multiple Regions.
    aws_cloud_watch_alarm: ?AwsCloudWatchAlarmDetails,

    /// Details for an CodeBuild project.
    aws_code_build_project: ?AwsCodeBuildProjectDetails,

    /// Provides details about an Database Migration Service (DMS) endpoint. An
    /// endpoint provides connection, data
    /// store type, and location information about your data store.
    aws_dms_endpoint: ?AwsDmsEndpointDetails,

    /// Provides details about an DMS replication instance. DMS uses a replication
    /// instance to connect to your
    /// source data store, read the source data, and format the data for consumption
    /// by the target data store.
    aws_dms_replication_instance: ?AwsDmsReplicationInstanceDetails,

    /// Provides details about an DMS replication task. A replication task moves a
    /// set of data from the source
    /// endpoint to the target endpoint.
    aws_dms_replication_task: ?AwsDmsReplicationTaskDetails,

    /// Details about a DynamoDB table.
    aws_dynamo_db_table: ?AwsDynamoDbTableDetails,

    /// Provides details about an Client VPN endpoint. A Client VPN endpoint is the
    /// resource that you
    /// create and configure to enable and manage client VPN sessions. It's the
    /// termination point for all client VPN sessions.
    aws_ec_2_client_vpn_endpoint: ?AwsEc2ClientVpnEndpointDetails,

    /// Details about an Elastic IP address.
    aws_ec_2_eip: ?AwsEc2EipDetails,

    /// Details about an EC2 instance related to a finding.
    aws_ec_2_instance: ?AwsEc2InstanceDetails,

    aws_ec_2_launch_template: ?AwsEc2LaunchTemplateDetails,

    /// Details about an EC2 network access control list (ACL).
    aws_ec_2_network_acl: ?AwsEc2NetworkAclDetails,

    /// Details for an EC2 network interface.
    aws_ec_2_network_interface: ?AwsEc2NetworkInterfaceDetails,

    /// Provides details about a route table. A route table contains a set of rules,
    /// called routes, that
    /// determine where to direct network traffic from your subnet or gateway.
    aws_ec_2_route_table: ?AwsEc2RouteTableDetails,

    /// Details for an EC2 security group.
    aws_ec_2_security_group: ?AwsEc2SecurityGroupDetails,

    /// Details about a subnet in Amazon EC2.
    aws_ec_2_subnet: ?AwsEc2SubnetDetails,

    /// Details about an Amazon EC2 transit gateway that interconnects your virtual
    /// private clouds (VPC) and on-premises networks.
    aws_ec_2_transit_gateway: ?AwsEc2TransitGatewayDetails,

    /// Details for an Amazon EC2 volume.
    aws_ec_2_volume: ?AwsEc2VolumeDetails,

    /// Details for an Amazon EC2 VPC.
    aws_ec_2_vpc: ?AwsEc2VpcDetails,

    /// Details about the service configuration for a VPC endpoint service.
    aws_ec_2_vpc_endpoint_service: ?AwsEc2VpcEndpointServiceDetails,

    /// Details about an Amazon EC2 VPC peering connection. A VPC peering connection
    /// is
    /// a networking connection between two VPCs that enables you to route traffic
    /// between them
    /// privately.
    aws_ec_2_vpc_peering_connection: ?AwsEc2VpcPeeringConnectionDetails,

    /// Details about an Amazon EC2 VPN connection.
    aws_ec_2_vpn_connection: ?AwsEc2VpnConnectionDetails,

    /// Information about an Amazon ECR image.
    aws_ecr_container_image: ?AwsEcrContainerImageDetails,

    /// Information about an Amazon Elastic Container Registry repository.
    aws_ecr_repository: ?AwsEcrRepositoryDetails,

    /// Details about an Amazon ECS cluster.
    aws_ecs_cluster: ?AwsEcsClusterDetails,

    /// Provides information about a Docker container that's part of a task.
    aws_ecs_container: ?AwsEcsContainerDetails,

    /// Details about a service within an ECS cluster.
    aws_ecs_service: ?AwsEcsServiceDetails,

    /// Details about a task in a cluster.
    aws_ecs_task: ?AwsEcsTaskDetails,

    /// Details about a task definition. A task definition describes the container
    /// and volume definitions of an Amazon Elastic Container Service task.
    aws_ecs_task_definition: ?AwsEcsTaskDefinitionDetails,

    /// Details about an Amazon EFS access point. An access point is an
    /// application-specific view into an EFS file system that
    /// applies an operating system user and group, and a file system path, to any
    /// file system request made through the access point.
    aws_efs_access_point: ?AwsEfsAccessPointDetails,

    /// Details about an Amazon EKS cluster.
    aws_eks_cluster: ?AwsEksClusterDetails,

    /// Details about an Elastic Beanstalk environment.
    aws_elastic_beanstalk_environment: ?AwsElasticBeanstalkEnvironmentDetails,

    /// Details for an Elasticsearch domain.
    aws_elasticsearch_domain: ?AwsElasticsearchDomainDetails,

    /// Contains details about a Classic Load Balancer.
    aws_elb_load_balancer: ?AwsElbLoadBalancerDetails,

    /// Details about a load balancer.
    aws_elbv_2_load_balancer: ?AwsElbv2LoadBalancerDetails,

    /// A schema defines the structure of events that are sent to Amazon
    /// EventBridge. Schema registries are containers for
    /// schemas. They collect and organize schemas so that your schemas are in
    /// logical groups.
    aws_event_schemas_registry: ?AwsEventSchemasRegistryDetails,

    /// Provides details about an Amazon EventBridge global endpoint. The endpoint
    /// can improve your application’s
    /// availability by making it Regional-fault tolerant.
    aws_events_endpoint: ?AwsEventsEndpointDetails,

    /// Provides details about Amazon EventBridge event bus for an endpoint. An
    /// event bus is a router that receives events
    /// and delivers them to zero or more destinations, or targets.
    aws_events_eventbus: ?AwsEventsEventbusDetails,

    /// Provides details about an Amazon GuardDuty detector. A detector is an object
    /// that represents the GuardDuty
    /// service. A detector is required for GuardDuty to become operational.
    aws_guard_duty_detector: ?AwsGuardDutyDetectorDetails,

    /// Details about an IAM access key related to a finding.
    aws_iam_access_key: ?AwsIamAccessKeyDetails,

    /// Contains details about an IAM group.
    aws_iam_group: ?AwsIamGroupDetails,

    /// Details about an IAM permissions policy.
    aws_iam_policy: ?AwsIamPolicyDetails,

    /// Details about an IAM role.
    aws_iam_role: ?AwsIamRoleDetails,

    /// Details about an IAM user.
    aws_iam_user: ?AwsIamUserDetails,

    /// Details about an Amazon Kinesis data stream.
    aws_kinesis_stream: ?AwsKinesisStreamDetails,

    /// Details about an KMS key.
    aws_kms_key: ?AwsKmsKeyDetails,

    /// Details about a Lambda function.
    aws_lambda_function: ?AwsLambdaFunctionDetails,

    /// Details for a Lambda layer version.
    aws_lambda_layer_version: ?AwsLambdaLayerVersionDetails,

    /// Provides details about an Amazon Managed Streaming for Apache Kafka (Amazon
    /// MSK) cluster.
    aws_msk_cluster: ?AwsMskClusterDetails,

    /// Details about an Network Firewall firewall.
    aws_network_firewall_firewall: ?AwsNetworkFirewallFirewallDetails,

    /// Details about an Network Firewall firewall policy.
    aws_network_firewall_firewall_policy: ?AwsNetworkFirewallFirewallPolicyDetails,

    /// Details about an Network Firewall rule group.
    aws_network_firewall_rule_group: ?AwsNetworkFirewallRuleGroupDetails,

    /// Details about an Amazon OpenSearch Service domain.
    aws_open_search_service_domain: ?AwsOpenSearchServiceDomainDetails,

    /// Details about an Amazon RDS database cluster.
    aws_rds_db_cluster: ?AwsRdsDbClusterDetails,

    /// Details about an Amazon RDS database cluster snapshot.
    aws_rds_db_cluster_snapshot: ?AwsRdsDbClusterSnapshotDetails,

    /// Details about an Amazon RDS database instance.
    aws_rds_db_instance: ?AwsRdsDbInstanceDetails,

    /// Details about an Amazon RDS DB security group.
    aws_rds_db_security_group: ?AwsRdsDbSecurityGroupDetails,

    /// Details about an Amazon RDS database snapshot.
    aws_rds_db_snapshot: ?AwsRdsDbSnapshotDetails,

    /// Details about an RDS event notification subscription.
    aws_rds_event_subscription: ?AwsRdsEventSubscriptionDetails,

    /// Contains details about an Amazon Redshift cluster.
    aws_redshift_cluster: ?AwsRedshiftClusterDetails,

    /// Provides details about an Amazon Route 53 hosted zone, including the four
    /// name servers assigned to the hosted
    /// zone. A hosted zone represents a collection of records that can be managed
    /// together, belonging to a single parent domain name.
    aws_route_53_hosted_zone: ?AwsRoute53HostedZoneDetails,

    /// Provides details about an Amazon Simple Storage Service (Amazon S3) access
    /// point. S3 access points are named network
    /// endpoints that are attached to S3 buckets that you can use to perform S3
    /// object operations.
    aws_s3_access_point: ?AwsS3AccessPointDetails,

    /// Details about the Amazon S3 Public Access Block configuration for an
    /// account.
    aws_s3_account_public_access_block: ?AwsS3AccountPublicAccessBlockDetails,

    /// Details about an S3 bucket related to a finding.
    aws_s3_bucket: ?AwsS3BucketDetails,

    /// Details about an S3 object related to a finding.
    aws_s3_object: ?AwsS3ObjectDetails,

    aws_sage_maker_notebook_instance: ?AwsSageMakerNotebookInstanceDetails,

    /// Details about a Secrets Manager secret.
    aws_secrets_manager_secret: ?AwsSecretsManagerSecretDetails,

    /// Details about an SNS topic.
    aws_sns_topic: ?AwsSnsTopicDetails,

    /// Details about an SQS queue.
    aws_sqs_queue: ?AwsSqsQueueDetails,

    /// Provides information about the state of a patch on an instance based on the
    /// patch baseline that was used to patch the instance.
    aws_ssm_patch_compliance: ?AwsSsmPatchComplianceDetails,

    /// Provides details about an Step Functions state machine, which is a workflow
    /// consisting of a series of event-driven steps.
    aws_step_function_state_machine: ?AwsStepFunctionStateMachineDetails,

    /// Details about a rate-based rule for global resources.
    aws_waf_rate_based_rule: ?AwsWafRateBasedRuleDetails,

    /// Details about a rate-based rule for Regional resources.
    aws_waf_regional_rate_based_rule: ?AwsWafRegionalRateBasedRuleDetails,

    /// Details about an WAF rule for Regional resources.
    aws_waf_regional_rule: ?AwsWafRegionalRuleDetails,

    /// Details about an WAF rule group for Regional resources.
    aws_waf_regional_rule_group: ?AwsWafRegionalRuleGroupDetails,

    /// Details about an WAF web access control list (web ACL) for Regional
    /// resources.
    aws_waf_regional_web_acl: ?AwsWafRegionalWebAclDetails,

    /// Details about an WAF rule for global resources.
    aws_waf_rule: ?AwsWafRuleDetails,

    /// Details about an WAF rule group for global resources.
    aws_waf_rule_group: ?AwsWafRuleGroupDetails,

    aws_wafv_2_rule_group: ?AwsWafv2RuleGroupDetails,

    aws_wafv_2_web_acl: ?AwsWafv2WebAclDetails,

    /// Details for an WAF web ACL.
    aws_waf_web_acl: ?AwsWafWebAclDetails,

    /// Information about the encryption configuration for X-Ray.
    aws_xray_encryption_config: ?AwsXrayEncryptionConfigDetails,

    /// Details about an external code repository with which you can connect your
    /// Amazon Web Services resources.
    /// The connection is established through Amazon Inspector.
    code_repository: ?CodeRepositoryDetails,

    /// Details about a container resource related to a finding.
    container: ?ContainerDetails,

    /// Details about a resource that are not available in a type-specific details
    /// object. Use
    /// the `Other` object in the following cases.
    ///
    /// * The type-specific object does not contain all of the fields that you want
    ///   to
    /// populate. In this case, first use the type-specific object to populate those
    /// fields.
    /// Use the `Other` object to populate the fields that are missing from the
    /// type-specific object.
    ///
    /// * The resource type does not have a corresponding object. This includes
    ///   resources
    /// for which the type is `Other`.
    other: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .aws_amazon_mq_broker = "AwsAmazonMqBroker",
        .aws_api_gateway_rest_api = "AwsApiGatewayRestApi",
        .aws_api_gateway_stage = "AwsApiGatewayStage",
        .aws_api_gateway_v2_api = "AwsApiGatewayV2Api",
        .aws_api_gateway_v2_stage = "AwsApiGatewayV2Stage",
        .aws_app_sync_graph_ql_api = "AwsAppSyncGraphQlApi",
        .aws_athena_work_group = "AwsAthenaWorkGroup",
        .aws_auto_scaling_auto_scaling_group = "AwsAutoScalingAutoScalingGroup",
        .aws_auto_scaling_launch_configuration = "AwsAutoScalingLaunchConfiguration",
        .aws_backup_backup_plan = "AwsBackupBackupPlan",
        .aws_backup_backup_vault = "AwsBackupBackupVault",
        .aws_backup_recovery_point = "AwsBackupRecoveryPoint",
        .aws_certificate_manager_certificate = "AwsCertificateManagerCertificate",
        .aws_cloud_formation_stack = "AwsCloudFormationStack",
        .aws_cloud_front_distribution = "AwsCloudFrontDistribution",
        .aws_cloud_trail_trail = "AwsCloudTrailTrail",
        .aws_cloud_watch_alarm = "AwsCloudWatchAlarm",
        .aws_code_build_project = "AwsCodeBuildProject",
        .aws_dms_endpoint = "AwsDmsEndpoint",
        .aws_dms_replication_instance = "AwsDmsReplicationInstance",
        .aws_dms_replication_task = "AwsDmsReplicationTask",
        .aws_dynamo_db_table = "AwsDynamoDbTable",
        .aws_ec_2_client_vpn_endpoint = "AwsEc2ClientVpnEndpoint",
        .aws_ec_2_eip = "AwsEc2Eip",
        .aws_ec_2_instance = "AwsEc2Instance",
        .aws_ec_2_launch_template = "AwsEc2LaunchTemplate",
        .aws_ec_2_network_acl = "AwsEc2NetworkAcl",
        .aws_ec_2_network_interface = "AwsEc2NetworkInterface",
        .aws_ec_2_route_table = "AwsEc2RouteTable",
        .aws_ec_2_security_group = "AwsEc2SecurityGroup",
        .aws_ec_2_subnet = "AwsEc2Subnet",
        .aws_ec_2_transit_gateway = "AwsEc2TransitGateway",
        .aws_ec_2_volume = "AwsEc2Volume",
        .aws_ec_2_vpc = "AwsEc2Vpc",
        .aws_ec_2_vpc_endpoint_service = "AwsEc2VpcEndpointService",
        .aws_ec_2_vpc_peering_connection = "AwsEc2VpcPeeringConnection",
        .aws_ec_2_vpn_connection = "AwsEc2VpnConnection",
        .aws_ecr_container_image = "AwsEcrContainerImage",
        .aws_ecr_repository = "AwsEcrRepository",
        .aws_ecs_cluster = "AwsEcsCluster",
        .aws_ecs_container = "AwsEcsContainer",
        .aws_ecs_service = "AwsEcsService",
        .aws_ecs_task = "AwsEcsTask",
        .aws_ecs_task_definition = "AwsEcsTaskDefinition",
        .aws_efs_access_point = "AwsEfsAccessPoint",
        .aws_eks_cluster = "AwsEksCluster",
        .aws_elastic_beanstalk_environment = "AwsElasticBeanstalkEnvironment",
        .aws_elasticsearch_domain = "AwsElasticsearchDomain",
        .aws_elb_load_balancer = "AwsElbLoadBalancer",
        .aws_elbv_2_load_balancer = "AwsElbv2LoadBalancer",
        .aws_event_schemas_registry = "AwsEventSchemasRegistry",
        .aws_events_endpoint = "AwsEventsEndpoint",
        .aws_events_eventbus = "AwsEventsEventbus",
        .aws_guard_duty_detector = "AwsGuardDutyDetector",
        .aws_iam_access_key = "AwsIamAccessKey",
        .aws_iam_group = "AwsIamGroup",
        .aws_iam_policy = "AwsIamPolicy",
        .aws_iam_role = "AwsIamRole",
        .aws_iam_user = "AwsIamUser",
        .aws_kinesis_stream = "AwsKinesisStream",
        .aws_kms_key = "AwsKmsKey",
        .aws_lambda_function = "AwsLambdaFunction",
        .aws_lambda_layer_version = "AwsLambdaLayerVersion",
        .aws_msk_cluster = "AwsMskCluster",
        .aws_network_firewall_firewall = "AwsNetworkFirewallFirewall",
        .aws_network_firewall_firewall_policy = "AwsNetworkFirewallFirewallPolicy",
        .aws_network_firewall_rule_group = "AwsNetworkFirewallRuleGroup",
        .aws_open_search_service_domain = "AwsOpenSearchServiceDomain",
        .aws_rds_db_cluster = "AwsRdsDbCluster",
        .aws_rds_db_cluster_snapshot = "AwsRdsDbClusterSnapshot",
        .aws_rds_db_instance = "AwsRdsDbInstance",
        .aws_rds_db_security_group = "AwsRdsDbSecurityGroup",
        .aws_rds_db_snapshot = "AwsRdsDbSnapshot",
        .aws_rds_event_subscription = "AwsRdsEventSubscription",
        .aws_redshift_cluster = "AwsRedshiftCluster",
        .aws_route_53_hosted_zone = "AwsRoute53HostedZone",
        .aws_s3_access_point = "AwsS3AccessPoint",
        .aws_s3_account_public_access_block = "AwsS3AccountPublicAccessBlock",
        .aws_s3_bucket = "AwsS3Bucket",
        .aws_s3_object = "AwsS3Object",
        .aws_sage_maker_notebook_instance = "AwsSageMakerNotebookInstance",
        .aws_secrets_manager_secret = "AwsSecretsManagerSecret",
        .aws_sns_topic = "AwsSnsTopic",
        .aws_sqs_queue = "AwsSqsQueue",
        .aws_ssm_patch_compliance = "AwsSsmPatchCompliance",
        .aws_step_function_state_machine = "AwsStepFunctionStateMachine",
        .aws_waf_rate_based_rule = "AwsWafRateBasedRule",
        .aws_waf_regional_rate_based_rule = "AwsWafRegionalRateBasedRule",
        .aws_waf_regional_rule = "AwsWafRegionalRule",
        .aws_waf_regional_rule_group = "AwsWafRegionalRuleGroup",
        .aws_waf_regional_web_acl = "AwsWafRegionalWebAcl",
        .aws_waf_rule = "AwsWafRule",
        .aws_waf_rule_group = "AwsWafRuleGroup",
        .aws_wafv_2_rule_group = "AwsWafv2RuleGroup",
        .aws_wafv_2_web_acl = "AwsWafv2WebAcl",
        .aws_waf_web_acl = "AwsWafWebAcl",
        .aws_xray_encryption_config = "AwsXrayEncryptionConfig",
        .code_repository = "CodeRepository",
        .container = "Container",
        .other = "Other",
    };
};
