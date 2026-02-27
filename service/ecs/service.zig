const AvailabilityZoneRebalancing = @import("availability_zone_rebalancing.zig").AvailabilityZoneRebalancing;
const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const ServiceCurrentRevisionSummary = @import("service_current_revision_summary.zig").ServiceCurrentRevisionSummary;
const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const DeploymentController = @import("deployment_controller.zig").DeploymentController;
const Deployment = @import("deployment.zig").Deployment;
const ServiceEvent = @import("service_event.zig").ServiceEvent;
const LaunchType = @import("launch_type.zig").LaunchType;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const PlacementConstraint = @import("placement_constraint.zig").PlacementConstraint;
const PlacementStrategy = @import("placement_strategy.zig").PlacementStrategy;
const PropagateTags = @import("propagate_tags.zig").PropagateTags;
const ResourceManagementType = @import("resource_management_type.zig").ResourceManagementType;
const SchedulingStrategy = @import("scheduling_strategy.zig").SchedulingStrategy;
const ServiceRegistry = @import("service_registry.zig").ServiceRegistry;
const Tag = @import("tag.zig").Tag;
const TaskSet = @import("task_set.zig").TaskSet;

/// Details on a service within a cluster.
pub const Service = struct {
    /// Indicates whether to use Availability Zone rebalancing for the service.
    ///
    /// For more information, see [Balancing an Amazon
    /// ECS service across Availability
    /// Zones](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-rebalancing.html) in the *
    /// Amazon
    /// Elastic Container Service Developer Guide*
    /// .
    ///
    /// The default behavior of `AvailabilityZoneRebalancing` differs between
    /// create and update requests:
    ///
    /// * For create service requests, when no value is specified for
    /// `AvailabilityZoneRebalancing`, Amazon ECS defaults the value to
    /// `ENABLED`.
    ///
    /// * For update service requests, when no value is specified for
    /// `AvailabilityZoneRebalancing`, Amazon ECS defaults to the
    /// existing service’s `AvailabilityZoneRebalancing` value. If the
    /// service never had an `AvailabilityZoneRebalancing` value set, Amazon
    /// ECS treats this as `DISABLED`.
    availability_zone_rebalancing: ?AvailabilityZoneRebalancing,

    /// The capacity provider strategy the service uses. When using the
    /// DescribeServices API,
    /// this field is omitted if the service was created using a launch type.
    capacity_provider_strategy: ?[]const CapacityProviderStrategyItem,

    /// The Amazon Resource Name (ARN) of the cluster that hosts the service.
    cluster_arn: ?[]const u8,

    /// The Unix timestamp for the time when the service was created.
    created_at: ?i64,

    /// The principal that created the service.
    created_by: ?[]const u8,

    /// The ARN of the current service deployment.
    current_service_deployment: ?[]const u8,

    /// The list of the service revisions.
    current_service_revisions: ?[]const ServiceCurrentRevisionSummary,

    /// Optional deployment parameters that control how many tasks run during the
    /// deployment
    /// and the ordering of stopping and starting tasks.
    deployment_configuration: ?DeploymentConfiguration,

    /// The deployment controller type the service is using.
    deployment_controller: ?DeploymentController,

    /// The current state of deployments for the service.
    deployments: ?[]const Deployment,

    /// The desired number of instantiations of the task definition to keep running
    /// on the
    /// service. This value is specified when the service is created with
    /// [CreateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateService.html) , and it can be modified with [UpdateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateService.html).
    desired_count: i32 = 0,

    /// Determines whether to use Amazon ECS managed tags for the tasks in the
    /// service. For
    /// more information, see [Tagging Your Amazon ECS
    /// Resources](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-using-tags.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    enable_ecs_managed_tags: bool = false,

    /// Determines whether the execute command functionality is turned on for the
    /// service. If
    /// `true`, the execute command functionality is turned on for all containers
    /// in tasks as part of the service.
    enable_execute_command: bool = false,

    /// The event stream for your service. A maximum of 100 of the latest events are
    /// displayed.
    events: ?[]const ServiceEvent,

    /// The period of time, in seconds, that the Amazon ECS service scheduler
    /// ignores
    /// unhealthy Elastic Load Balancing, VPC Lattice, and container health checks
    /// after a task
    /// has first started.
    ///
    /// If your service has more running tasks than desired, unhealthy tasks in the
    /// grace
    /// period might be stopped to reach the desired count.
    health_check_grace_period_seconds: ?i32,

    /// The launch type the service is using. When using the DescribeServices API,
    /// this field
    /// is omitted if the service was created using a capacity provider strategy.
    launch_type: ?LaunchType,

    /// A list of Elastic Load Balancing load balancer objects. It contains the load
    /// balancer
    /// name, the container name, and the container port to access from the load
    /// balancer. The
    /// container name is as it appears in a container definition.
    load_balancers: ?[]const LoadBalancer,

    /// The VPC subnet and security group configuration for tasks that receive their
    /// own
    /// elastic network interface by using the `awsvpc` networking mode.
    network_configuration: ?NetworkConfiguration,

    /// The number of tasks in the cluster that are in the `PENDING` state.
    pending_count: i32 = 0,

    /// The placement constraints for the tasks in the service.
    placement_constraints: ?[]const PlacementConstraint,

    /// The placement strategy that determines how tasks for the service are placed.
    placement_strategy: ?[]const PlacementStrategy,

    /// The operating system that your tasks in the service run on. A platform
    /// family is
    /// specified only for tasks using the Fargate launch type.
    ///
    /// All tasks that run as part of this service must use the same
    /// `platformFamily` value as the service (for example,
    /// `LINUX`).
    platform_family: ?[]const u8,

    /// The platform version to run your service on. A platform version is only
    /// specified for
    /// tasks that are hosted on Fargate. If one isn't specified, the `LATEST`
    /// platform
    /// version is used. For more information, see [Fargate
    /// Platform
    /// Versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service
    /// Developer Guide*.
    platform_version: ?[]const u8,

    /// Determines whether to propagate the tags from the task definition or the
    /// service to
    /// the task. If no value is specified, the tags aren't propagated.
    propagate_tags: ?PropagateTags,

    /// Identifies whether an ECS Service is an Express Service managed by ECS, or
    /// managed by the customer. The
    /// valid values are `ECS` and `CUSTOMER`
    resource_management_type: ?ResourceManagementType,

    /// The ARN of the IAM role that's associated with the service. It allows the
    /// Amazon ECS
    /// container agent to register container instances with an Elastic Load
    /// Balancing load
    /// balancer.
    role_arn: ?[]const u8,

    /// The number of tasks in the cluster that are in the `RUNNING` state.
    running_count: i32 = 0,

    /// The scheduling strategy to use for the service. For more information, see
    /// [Services](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html).
    ///
    /// There are two service scheduler strategies available.
    ///
    /// * `REPLICA`-The replica scheduling strategy places and maintains the
    /// desired number of tasks across your cluster. By default, the service
    /// scheduler
    /// spreads tasks across Availability Zones. You can use task placement
    /// strategies
    /// and constraints to customize task placement decisions.
    ///
    /// * `DAEMON`-The daemon scheduling strategy deploys exactly one task on
    /// each active container instance. This task meets all of the task placement
    /// constraints that you specify in your cluster. The service scheduler also
    /// evaluates the task placement constraints for running tasks. It stop tasks
    /// that
    /// don't meet the placement constraints.
    ///
    /// Fargate tasks don't support the `DAEMON` scheduling
    /// strategy.
    scheduling_strategy: ?SchedulingStrategy,

    /// The ARN that identifies the service. For more information about the ARN
    /// format, see
    /// [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-account-settings.html#ecs-resource-ids) in the *Amazon ECS Developer
    /// Guide*.
    service_arn: ?[]const u8,

    /// The name of your service. Up to 255 letters (uppercase and lowercase),
    /// numbers,
    /// underscores, and hyphens are allowed. Service names must be unique within a
    /// cluster.
    /// However, you can have similarly named services in multiple clusters within a
    /// Region or
    /// across multiple Regions.
    service_name: ?[]const u8,

    /// The details for the service discovery registries to assign to this service.
    /// For more
    /// information, see [Service
    /// Discovery](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-discovery.html).
    service_registries: ?[]const ServiceRegistry,

    /// The status of the service. The valid values are `ACTIVE`,
    /// `DRAINING`, or `INACTIVE`.
    status: ?[]const u8,

    /// The metadata that you apply to the service to help you categorize and
    /// organize them.
    /// Each tag consists of a key and an optional value. You define bot the key and
    /// value.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    ///
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only
    /// one value.
    ///
    /// * Maximum key length - 128 Unicode characters in UTF-8
    ///
    /// * Maximum value length - 256 Unicode characters in UTF-8
    ///
    /// * If your tagging schema is used across multiple services and resources,
    /// remember that other services may have restrictions on allowed characters.
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in
    /// UTF-8, and the following characters: + - = . _ : / @.
    ///
    /// * Tag keys and values are case-sensitive.
    ///
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase
    /// combination of such as a prefix for either keys or values as it is reserved
    /// for
    /// Amazon Web
    /// Services use. You cannot edit or delete tag keys or values with
    /// this prefix. Tags with this prefix do not count against your tags per
    /// resource
    /// limit.
    tags: ?[]const Tag,

    /// The task definition to use for tasks in the service. This value is specified
    /// when the
    /// service is created with
    /// [CreateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateService.html),
    /// and it can be modified with
    /// [UpdateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateService.html).
    task_definition: ?[]const u8,

    /// Information about a set of Amazon ECS tasks in either an CodeDeploy or an
    /// `EXTERNAL` deployment. An Amazon ECS task set includes details such as
    /// the desired number of tasks, how many tasks are running, and whether the
    /// task set serves
    /// production traffic.
    task_sets: ?[]const TaskSet,

    pub const json_field_names = .{
        .availability_zone_rebalancing = "availabilityZoneRebalancing",
        .capacity_provider_strategy = "capacityProviderStrategy",
        .cluster_arn = "clusterArn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .current_service_deployment = "currentServiceDeployment",
        .current_service_revisions = "currentServiceRevisions",
        .deployment_configuration = "deploymentConfiguration",
        .deployment_controller = "deploymentController",
        .deployments = "deployments",
        .desired_count = "desiredCount",
        .enable_ecs_managed_tags = "enableECSManagedTags",
        .enable_execute_command = "enableExecuteCommand",
        .events = "events",
        .health_check_grace_period_seconds = "healthCheckGracePeriodSeconds",
        .launch_type = "launchType",
        .load_balancers = "loadBalancers",
        .network_configuration = "networkConfiguration",
        .pending_count = "pendingCount",
        .placement_constraints = "placementConstraints",
        .placement_strategy = "placementStrategy",
        .platform_family = "platformFamily",
        .platform_version = "platformVersion",
        .propagate_tags = "propagateTags",
        .resource_management_type = "resourceManagementType",
        .role_arn = "roleArn",
        .running_count = "runningCount",
        .scheduling_strategy = "schedulingStrategy",
        .service_arn = "serviceArn",
        .service_name = "serviceName",
        .service_registries = "serviceRegistries",
        .status = "status",
        .tags = "tags",
        .task_definition = "taskDefinition",
        .task_sets = "taskSets",
    };
};
