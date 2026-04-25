const AwsEcsServiceCapacityProviderStrategyDetails = @import("aws_ecs_service_capacity_provider_strategy_details.zig").AwsEcsServiceCapacityProviderStrategyDetails;
const AwsEcsServiceDeploymentConfigurationDetails = @import("aws_ecs_service_deployment_configuration_details.zig").AwsEcsServiceDeploymentConfigurationDetails;
const AwsEcsServiceDeploymentControllerDetails = @import("aws_ecs_service_deployment_controller_details.zig").AwsEcsServiceDeploymentControllerDetails;
const AwsEcsServiceLoadBalancersDetails = @import("aws_ecs_service_load_balancers_details.zig").AwsEcsServiceLoadBalancersDetails;
const AwsEcsServiceNetworkConfigurationDetails = @import("aws_ecs_service_network_configuration_details.zig").AwsEcsServiceNetworkConfigurationDetails;
const AwsEcsServicePlacementConstraintsDetails = @import("aws_ecs_service_placement_constraints_details.zig").AwsEcsServicePlacementConstraintsDetails;
const AwsEcsServicePlacementStrategiesDetails = @import("aws_ecs_service_placement_strategies_details.zig").AwsEcsServicePlacementStrategiesDetails;
const AwsEcsServiceServiceRegistriesDetails = @import("aws_ecs_service_service_registries_details.zig").AwsEcsServiceServiceRegistriesDetails;

/// Provides details about a service within an ECS cluster.
pub const AwsEcsServiceDetails = struct {
    /// The capacity provider strategy that the service uses.
    capacity_provider_strategy: ?[]const AwsEcsServiceCapacityProviderStrategyDetails = null,

    /// The ARN of the cluster that hosts the service.
    cluster: ?[]const u8 = null,

    /// Deployment parameters for the service. Includes the number of tasks that run
    /// and the order in which to start and stop tasks.
    deployment_configuration: ?AwsEcsServiceDeploymentConfigurationDetails = null,

    /// Contains the deployment controller type that the service uses.
    deployment_controller: ?AwsEcsServiceDeploymentControllerDetails = null,

    /// The number of instantiations of the task definition to run on the service.
    desired_count: ?i32 = null,

    /// Whether to enable Amazon ECS managed tags for the tasks in the service.
    enable_ecs_managed_tags: ?bool = null,

    /// Whether the execute command functionality is enabled for the service.
    enable_execute_command: ?bool = null,

    /// After a task starts, the amount of time in seconds that the Amazon ECS
    /// service scheduler ignores unhealthy Elastic Load Balancing target health
    /// checks.
    health_check_grace_period_seconds: ?i32 = null,

    /// The launch type that the service uses.
    ///
    /// Valid values: `EC2` | `FARGATE` | `EXTERNAL`
    launch_type: ?[]const u8 = null,

    /// Information about the load balancers that the service uses.
    load_balancers: ?[]const AwsEcsServiceLoadBalancersDetails = null,

    /// The name of the service.
    name: ?[]const u8 = null,

    /// For tasks that use the `awsvpc` networking mode, the VPC subnet and security
    /// group configuration.
    network_configuration: ?AwsEcsServiceNetworkConfigurationDetails = null,

    /// The placement constraints for the tasks in the service.
    placement_constraints: ?[]const AwsEcsServicePlacementConstraintsDetails = null,

    /// Information about how tasks for the service are placed.
    placement_strategies: ?[]const AwsEcsServicePlacementStrategiesDetails = null,

    /// The platform version on which to run the service. Only specified for tasks
    /// that are hosted on Fargate. If a platform version is not specified, the
    /// `LATEST` platform version is used by default.
    platform_version: ?[]const u8 = null,

    /// Indicates whether to propagate the tags from the task definition to the task
    /// or from the service to the task. If no value is provided, then tags are not
    /// propagated.
    ///
    /// Valid values: `TASK_DEFINITION` | `SERVICE`
    propagate_tags: ?[]const u8 = null,

    /// The ARN of the IAM role that is associated with the service. The role allows
    /// the Amazon ECS container agent to register container instances with an
    /// Elastic Load Balancing load balancer.
    role: ?[]const u8 = null,

    /// The scheduling strategy to use for the service.
    ///
    /// The `REPLICA` scheduling strategy places and maintains the desired number of
    /// tasks across the cluster. By default, the service scheduler spreads tasks
    /// across Availability Zones. Task placement strategies and constraints are
    /// used to customize task placement decisions.
    ///
    /// The `DAEMON` scheduling strategy deploys exactly one task on each active
    /// container instance that meets all of the task placement constraints that are
    /// specified in the cluster. The service scheduler also evaluates the task
    /// placement constraints for running tasks and stops tasks that don't meet the
    /// placement constraints.
    ///
    /// Valid values: `REPLICA` | `DAEMON`
    scheduling_strategy: ?[]const u8 = null,

    /// The ARN of the service.
    service_arn: ?[]const u8 = null,

    /// The name of the service.
    ///
    /// The name can contain up to 255 characters. It can use letters, numbers,
    /// underscores, and hyphens.
    service_name: ?[]const u8 = null,

    /// Information about the service discovery registries to assign to the service.
    service_registries: ?[]const AwsEcsServiceServiceRegistriesDetails = null,

    /// The task definition to use for tasks in the service.
    task_definition: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_provider_strategy = "CapacityProviderStrategy",
        .cluster = "Cluster",
        .deployment_configuration = "DeploymentConfiguration",
        .deployment_controller = "DeploymentController",
        .desired_count = "DesiredCount",
        .enable_ecs_managed_tags = "EnableEcsManagedTags",
        .enable_execute_command = "EnableExecuteCommand",
        .health_check_grace_period_seconds = "HealthCheckGracePeriodSeconds",
        .launch_type = "LaunchType",
        .load_balancers = "LoadBalancers",
        .name = "Name",
        .network_configuration = "NetworkConfiguration",
        .placement_constraints = "PlacementConstraints",
        .placement_strategies = "PlacementStrategies",
        .platform_version = "PlatformVersion",
        .propagate_tags = "PropagateTags",
        .role = "Role",
        .scheduling_strategy = "SchedulingStrategy",
        .service_arn = "ServiceArn",
        .service_name = "ServiceName",
        .service_registries = "ServiceRegistries",
        .task_definition = "TaskDefinition",
    };
};
