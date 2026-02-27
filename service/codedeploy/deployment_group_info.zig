const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const AutoRollbackConfiguration = @import("auto_rollback_configuration.zig").AutoRollbackConfiguration;
const AutoScalingGroup = @import("auto_scaling_group.zig").AutoScalingGroup;
const BlueGreenDeploymentConfiguration = @import("blue_green_deployment_configuration.zig").BlueGreenDeploymentConfiguration;
const ComputePlatform = @import("compute_platform.zig").ComputePlatform;
const DeploymentStyle = @import("deployment_style.zig").DeploymentStyle;
const EC2TagFilter = @import("ec2_tag_filter.zig").EC2TagFilter;
const EC2TagSet = @import("ec2_tag_set.zig").EC2TagSet;
const ECSService = @import("ecs_service.zig").ECSService;
const LastDeploymentInfo = @import("last_deployment_info.zig").LastDeploymentInfo;
const LoadBalancerInfo = @import("load_balancer_info.zig").LoadBalancerInfo;
const TagFilter = @import("tag_filter.zig").TagFilter;
const OnPremisesTagSet = @import("on_premises_tag_set.zig").OnPremisesTagSet;
const OutdatedInstancesStrategy = @import("outdated_instances_strategy.zig").OutdatedInstancesStrategy;
const RevisionLocation = @import("revision_location.zig").RevisionLocation;
const TriggerConfig = @import("trigger_config.zig").TriggerConfig;

/// Information about a deployment group.
pub const DeploymentGroupInfo = struct {
    /// A list of alarms associated with the deployment group.
    alarm_configuration: ?AlarmConfiguration,

    /// The application name.
    application_name: ?[]const u8,

    /// Information about the automatic rollback configuration associated with the
    /// deployment
    /// group.
    auto_rollback_configuration: ?AutoRollbackConfiguration,

    /// A list of associated Auto Scaling groups.
    auto_scaling_groups: ?[]const AutoScalingGroup,

    /// Information about blue/green deployment options for a deployment group.
    blue_green_deployment_configuration: ?BlueGreenDeploymentConfiguration,

    /// The destination platform type for the deployment (`Lambda`,
    /// `Server`, or `ECS`).
    compute_platform: ?ComputePlatform,

    /// The deployment configuration name.
    deployment_config_name: ?[]const u8,

    /// The deployment group ID.
    deployment_group_id: ?[]const u8,

    /// The deployment group name.
    deployment_group_name: ?[]const u8,

    /// Information about the type of deployment, either in-place or blue/green, you
    /// want to
    /// run and whether to route deployment traffic behind a load balancer.
    deployment_style: ?DeploymentStyle,

    /// The Amazon EC2 tags on which to filter. The deployment group includes EC2
    /// instances with any of the specified tags.
    ec_2_tag_filters: ?[]const EC2TagFilter,

    /// Information about groups of tags applied to an Amazon EC2 instance. The
    /// deployment group includes only Amazon EC2 instances identified by all of the
    /// tag
    /// groups. Cannot be used in the same call as ec2TagFilters.
    ec_2_tag_set: ?EC2TagSet,

    /// The target Amazon ECS services in the deployment group. This applies only to
    /// deployment groups that use the Amazon ECS compute platform. A target Amazon
    /// ECS service is specified as an Amazon ECS cluster and service name
    /// pair using the format `:`.
    ecs_services: ?[]const ECSService,

    /// Information about the most recent attempted deployment to the deployment
    /// group.
    last_attempted_deployment: ?LastDeploymentInfo,

    /// Information about the most recent successful deployment to the deployment
    /// group.
    last_successful_deployment: ?LastDeploymentInfo,

    /// Information about the load balancer to use in a deployment.
    load_balancer_info: ?LoadBalancerInfo,

    /// The on-premises instance tags on which to filter. The deployment group
    /// includes
    /// on-premises instances with any of the specified tags.
    on_premises_instance_tag_filters: ?[]const TagFilter,

    /// Information about groups of tags applied to an on-premises instance. The
    /// deployment
    /// group includes only on-premises instances identified by all the tag groups.
    /// Cannot be
    /// used in the same call as onPremisesInstanceTagFilters.
    on_premises_tag_set: ?OnPremisesTagSet,

    /// Indicates what happens when new Amazon EC2 instances are launched
    /// mid-deployment and do not receive the deployed application revision.
    ///
    /// If this option is set to `UPDATE` or is unspecified, CodeDeploy initiates
    /// one or more 'auto-update outdated instances' deployments to apply the
    /// deployed
    /// application revision to the new Amazon EC2 instances.
    ///
    /// If this option is set to `IGNORE`, CodeDeploy does not initiate a
    /// deployment to update the new Amazon EC2 instances. This may result in
    /// instances
    /// having different revisions.
    outdated_instances_strategy: ?OutdatedInstancesStrategy,

    /// A service role Amazon Resource Name (ARN) that grants CodeDeploy permission
    /// to make
    /// calls to Amazon Web Services services on your behalf. For more information,
    /// see [Create a
    /// Service Role for
    /// CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/getting-started-create-service-role.html) in the *CodeDeploy User Guide*.
    service_role_arn: ?[]const u8,

    /// Information about the deployment group's target revision, including type and
    /// location.
    target_revision: ?RevisionLocation,

    /// Indicates whether the deployment group was configured to have CodeDeploy
    /// install a termination hook into an Auto Scaling group.
    ///
    /// For more information about the termination hook, see [How Amazon EC2 Auto
    /// Scaling works with
    /// CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/integrations-aws-auto-scaling.html#integrations-aws-auto-scaling-behaviors) in the
    /// *CodeDeploy User Guide*.
    termination_hook_enabled: bool = false,

    /// Information about triggers associated with the deployment group.
    trigger_configurations: ?[]const TriggerConfig,

    pub const json_field_names = .{
        .alarm_configuration = "alarmConfiguration",
        .application_name = "applicationName",
        .auto_rollback_configuration = "autoRollbackConfiguration",
        .auto_scaling_groups = "autoScalingGroups",
        .blue_green_deployment_configuration = "blueGreenDeploymentConfiguration",
        .compute_platform = "computePlatform",
        .deployment_config_name = "deploymentConfigName",
        .deployment_group_id = "deploymentGroupId",
        .deployment_group_name = "deploymentGroupName",
        .deployment_style = "deploymentStyle",
        .ec_2_tag_filters = "ec2TagFilters",
        .ec_2_tag_set = "ec2TagSet",
        .ecs_services = "ecsServices",
        .last_attempted_deployment = "lastAttemptedDeployment",
        .last_successful_deployment = "lastSuccessfulDeployment",
        .load_balancer_info = "loadBalancerInfo",
        .on_premises_instance_tag_filters = "onPremisesInstanceTagFilters",
        .on_premises_tag_set = "onPremisesTagSet",
        .outdated_instances_strategy = "outdatedInstancesStrategy",
        .service_role_arn = "serviceRoleArn",
        .target_revision = "targetRevision",
        .termination_hook_enabled = "terminationHookEnabled",
        .trigger_configurations = "triggerConfigurations",
    };
};
