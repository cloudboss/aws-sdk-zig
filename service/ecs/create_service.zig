const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AvailabilityZoneRebalancing = @import("availability_zone_rebalancing.zig").AvailabilityZoneRebalancing;
const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const DeploymentController = @import("deployment_controller.zig").DeploymentController;
const LaunchType = @import("launch_type.zig").LaunchType;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const PlacementConstraint = @import("placement_constraint.zig").PlacementConstraint;
const PlacementStrategy = @import("placement_strategy.zig").PlacementStrategy;
const PropagateTags = @import("propagate_tags.zig").PropagateTags;
const SchedulingStrategy = @import("scheduling_strategy.zig").SchedulingStrategy;
const ServiceConnectConfiguration = @import("service_connect_configuration.zig").ServiceConnectConfiguration;
const ServiceRegistry = @import("service_registry.zig").ServiceRegistry;
const Tag = @import("tag.zig").Tag;
const ServiceVolumeConfiguration = @import("service_volume_configuration.zig").ServiceVolumeConfiguration;
const VpcLatticeConfiguration = @import("vpc_lattice_configuration.zig").VpcLatticeConfiguration;
const Service = @import("service.zig").Service;

pub const CreateServiceInput = struct {
    /// Indicates whether to use Availability Zone rebalancing for the service.
    ///
    /// For more information, see [Balancing an Amazon ECS service across
    /// Availability
    /// Zones](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-rebalancing.html) in the * Amazon Elastic Container Service Developer Guide* .
    ///
    /// The default behavior of `AvailabilityZoneRebalancing` differs between create
    /// and update requests:
    ///
    /// * For create service requests, when no value is specified for
    ///   `AvailabilityZoneRebalancing`, Amazon ECS defaults the value to `ENABLED`.
    /// * For update service requests, when no value is specified for
    ///   `AvailabilityZoneRebalancing`, Amazon ECS defaults to the existing
    ///   service’s `AvailabilityZoneRebalancing` value. If the service never had an
    ///   `AvailabilityZoneRebalancing` value set, Amazon ECS treats this as
    ///   `DISABLED`.
    availability_zone_rebalancing: ?AvailabilityZoneRebalancing = null,

    /// The capacity provider strategy to use for the service.
    ///
    /// If you want to use Amazon ECS Managed Instances, you must use the
    /// `capacityProviderStrategy` request parameter and omit the `launchType`
    /// request parameter.
    ///
    /// If a `capacityProviderStrategy` is specified, the `launchType` parameter
    /// must be omitted. If no `capacityProviderStrategy` or `launchType` is
    /// specified, the `defaultCapacityProviderStrategy` for the cluster is used.
    ///
    /// A capacity provider strategy can contain a maximum of 20 capacity providers.
    capacity_provider_strategy: ?[]const CapacityProviderStrategyItem = null,

    /// An identifier that you provide to ensure the idempotency of the request. It
    /// must be unique and is case sensitive. Up to 36 ASCII characters in the range
    /// of 33-126 (inclusive) are allowed.
    client_token: ?[]const u8 = null,

    /// The short name or full Amazon Resource Name (ARN) of the cluster that you
    /// run your service on. If you do not specify a cluster, the default cluster is
    /// assumed.
    cluster: ?[]const u8 = null,

    /// Optional deployment parameters that control how many tasks run during the
    /// deployment and the ordering of stopping and starting tasks.
    deployment_configuration: ?DeploymentConfiguration = null,

    /// The deployment controller to use for the service. If no deployment
    /// controller is specified, the default value of `ECS` is used.
    deployment_controller: ?DeploymentController = null,

    /// The number of instantiations of the specified task definition to place and
    /// keep running in your service.
    ///
    /// This is required if `schedulingStrategy` is `REPLICA` or isn't specified. If
    /// `schedulingStrategy` is `DAEMON` then this isn't required.
    desired_count: ?i32 = null,

    /// Specifies whether to turn on Amazon ECS managed tags for the tasks within
    /// the service. For more information, see [Tagging your Amazon ECS
    /// resources](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-using-tags.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// When you use Amazon ECS managed tags, you must set the `propagateTags`
    /// request parameter.
    enable_ecs_managed_tags: ?bool = null,

    /// Determines whether the execute command functionality is turned on for the
    /// service. If `true`, this enables execute command functionality on all
    /// containers in the service tasks.
    enable_execute_command: ?bool = null,

    /// The period of time, in seconds, that the Amazon ECS service scheduler
    /// ignores unhealthy Elastic Load Balancing, VPC Lattice, and container health
    /// checks after a task has first started. If you do not specify a health check
    /// grace period value, the default value of 0 is used. If you do not use any of
    /// the health checks, then `healthCheckGracePeriodSeconds` is unused.
    ///
    /// If your service has more running tasks than desired, unhealthy tasks in the
    /// grace period might be stopped to reach the desired count.
    health_check_grace_period_seconds: ?i32 = null,

    /// The infrastructure that you run your service on. For more information, see
    /// [Amazon ECS launch
    /// types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// If you want to use Amazon ECS Managed Instances, you must use the
    /// `capacityProviderStrategy` request parameter and omit the `launchType`
    /// request parameter.
    ///
    /// The `FARGATE` launch type runs your tasks on Fargate On-Demand
    /// infrastructure.
    ///
    /// Fargate Spot infrastructure is available for use but a capacity provider
    /// strategy must be used. For more information, see [Fargate capacity
    /// providers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-capacity-providers.html) in the *Amazon ECS Developer Guide*.
    ///
    /// The `EC2` launch type runs your tasks on Amazon EC2 instances registered to
    /// your cluster.
    ///
    /// The `EXTERNAL` launch type runs your tasks on your on-premises server or
    /// virtual machine (VM) capacity registered to your cluster.
    ///
    /// A service can use either a launch type or a capacity provider strategy. If a
    /// `launchType` is specified, the `capacityProviderStrategy` parameter must be
    /// omitted.
    launch_type: ?LaunchType = null,

    /// A load balancer object representing the load balancers to use with your
    /// service. For more information, see [Service load
    /// balancing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-load-balancing.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// If the service uses the `ECS` deployment controller and using either an
    /// Application Load Balancer or Network Load Balancer, you must specify one or
    /// more target group ARNs to attach to the service. The service-linked role is
    /// required for services that use multiple target groups. For more information,
    /// see [Using service-linked roles for Amazon
    /// ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using-service-linked-roles.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// If the service uses the `CODE_DEPLOY` deployment controller, the service is
    /// required to use either an Application Load Balancer or Network Load
    /// Balancer. When creating an CodeDeploy deployment group, you specify two
    /// target groups (referred to as a `targetGroupPair`). During a deployment,
    /// CodeDeploy determines which task set in your service has the status
    /// `PRIMARY`, and it associates one target group with it. Then, it also
    /// associates the other target group with the replacement task set. The load
    /// balancer can also have up to two listeners: a required listener for
    /// production traffic and an optional listener that you can use to perform
    /// validation tests with Lambda functions before routing production traffic to
    /// it.
    ///
    /// If you use the `CODE_DEPLOY` deployment controller, these values can be
    /// changed when updating the service.
    ///
    /// For Application Load Balancers and Network Load Balancers, this object must
    /// contain the load balancer target group ARN, the container name, and the
    /// container port to access from the load balancer. The container name must be
    /// as it appears in a container definition. The load balancer name parameter
    /// must be omitted. When a task from this service is placed on a container
    /// instance, the container instance and port combination is registered as a
    /// target in the target group that's specified here.
    ///
    /// For Classic Load Balancers, this object must contain the load balancer name,
    /// the container name , and the container port to access from the load
    /// balancer. The container name must be as it appears in a container
    /// definition. The target group ARN parameter must be omitted. When a task from
    /// this service is placed on a container instance, the container instance is
    /// registered with the load balancer that's specified here.
    ///
    /// Services with tasks that use the `awsvpc` network mode (for example, those
    /// with the Fargate launch type) only support Application Load Balancers and
    /// Network Load Balancers. Classic Load Balancers aren't supported. Also, when
    /// you create any target groups for these services, you must choose `ip` as the
    /// target type, not `instance`. This is because tasks that use the `awsvpc`
    /// network mode are associated with an elastic network interface, not an Amazon
    /// EC2 instance.
    load_balancers: ?[]const LoadBalancer = null,

    /// The network configuration for the service. This parameter is required for
    /// task definitions that use the `awsvpc` network mode to receive their own
    /// elastic network interface, and it isn't supported for other network modes.
    /// For more information, see [Task
    /// networking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html) in the *Amazon Elastic Container Service Developer Guide*.
    network_configuration: ?NetworkConfiguration = null,

    /// An array of placement constraint objects to use for tasks in your service.
    /// You can specify a maximum of 10 constraints for each task. This limit
    /// includes constraints in the task definition and those specified at runtime.
    placement_constraints: ?[]const PlacementConstraint = null,

    /// The placement strategy objects to use for tasks in your service. You can
    /// specify a maximum of 5 strategy rules for each service.
    placement_strategy: ?[]const PlacementStrategy = null,

    /// The platform version that your tasks in the service are running on. A
    /// platform version is specified only for tasks using the Fargate launch type.
    /// If one isn't specified, the `LATEST` platform version is used. For more
    /// information, see [Fargate platform
    /// versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service Developer Guide*.
    platform_version: ?[]const u8 = null,

    /// Specifies whether to propagate the tags from the task definition to the
    /// task. If no value is specified, the tags aren't propagated. Tags can only be
    /// propagated to the task during task creation. To add tags to a task after
    /// task creation, use the
    /// [TagResource](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_TagResource.html) API action.
    ///
    /// You must set this to a value other than `NONE` when you use Cost Explorer.
    /// For more information, see [Amazon ECS usage
    /// reports](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/usage-reports.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// The default is `NONE`.
    propagate_tags: ?PropagateTags = null,

    /// The name or full Amazon Resource Name (ARN) of the IAM role that allows
    /// Amazon ECS to make calls to your load balancer on your behalf. This
    /// parameter is only permitted if you are using a load balancer with your
    /// service and your task definition doesn't use the `awsvpc` network mode. If
    /// you specify the `role` parameter, you must also specify a load balancer
    /// object with the `loadBalancers` parameter.
    ///
    /// If your account has already created the Amazon ECS service-linked role, that
    /// role is used for your service unless you specify a role here. The
    /// service-linked role is required if your task definition uses the `awsvpc`
    /// network mode or if the service is configured to use service discovery, an
    /// external deployment controller, multiple target groups, or Elastic Inference
    /// accelerators in which case you don't specify a role here. For more
    /// information, see [Using service-linked roles for Amazon
    /// ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using-service-linked-roles.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// If your specified role has a path other than `/`, then you must either
    /// specify the full role ARN (this is recommended) or prefix the role name with
    /// the path. For example, if a role with the name `bar` has a path of `/foo/`
    /// then you would specify `/foo/bar` as the role name. For more information,
    /// see [Friendly names and
    /// paths](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-friendly-names) in the *IAM User Guide*.
    role: ?[]const u8 = null,

    /// The scheduling strategy to use for the service. For more information, see
    /// [Services](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html).
    ///
    /// There are two service scheduler strategies available:
    ///
    /// * `REPLICA`-The replica scheduling strategy places and maintains the desired
    ///   number of tasks across your cluster. By default, the service scheduler
    ///   spreads tasks across Availability Zones. You can use task placement
    ///   strategies and constraints to customize task placement decisions. This
    ///   scheduler strategy is required if the service uses the `CODE_DEPLOY` or
    ///   `EXTERNAL` deployment controller types.
    /// * `DAEMON`-The daemon scheduling strategy deploys exactly one task on each
    ///   active container instance that meets all of the task placement constraints
    ///   that you specify in your cluster. The service scheduler also evaluates the
    ///   task placement constraints for running tasks and will stop tasks that
    ///   don't meet the placement constraints. When you're using this strategy, you
    ///   don't need to specify a desired number of tasks, a task placement
    ///   strategy, or use Service Auto Scaling policies.
    ///
    /// Tasks using the Fargate launch type or the `CODE_DEPLOY` or `EXTERNAL`
    /// deployment controller types don't support the `DAEMON` scheduling strategy.
    scheduling_strategy: ?SchedulingStrategy = null,

    /// The configuration for this service to discover and connect to services, and
    /// be discovered by, and connected from, other services within a namespace.
    ///
    /// Tasks that run in a namespace can use short names to connect to services in
    /// the namespace. Tasks can connect to services across all of the clusters in
    /// the namespace. Tasks connect through a managed proxy container that collects
    /// logs and metrics for increased visibility. Only the tasks that Amazon ECS
    /// services create are supported with Service Connect. For more information,
    /// see [Service
    /// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.
    service_connect_configuration: ?ServiceConnectConfiguration = null,

    /// The name of your service. Up to 255 letters (uppercase and lowercase),
    /// numbers, underscores, and hyphens are allowed. Service names must be unique
    /// within a cluster, but you can have similarly named services in multiple
    /// clusters within a Region or across multiple Regions.
    service_name: []const u8,

    /// The details of the service discovery registry to associate with this
    /// service. For more information, see [Service
    /// discovery](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-discovery.html).
    ///
    /// Each service may be associated with one service registry. Multiple service
    /// registries for each service isn't supported.
    service_registries: ?[]const ServiceRegistry = null,

    /// The metadata that you apply to the service to help you categorize and
    /// organize them. Each tag consists of a key and an optional value, both of
    /// which you define. When a service is deleted, the tags are deleted as well.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8
    /// * Maximum value length - 256 Unicode characters in UTF-8
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case-sensitive.
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination of such
    ///   as a prefix for either keys or values as it is reserved for Amazon Web
    ///   Services use. You cannot edit or delete tag keys or values with this
    ///   prefix. Tags with this prefix do not count against your tags per resource
    ///   limit.
    tags: ?[]const Tag = null,

    /// The `family` and `revision` (`family:revision`) or full ARN of the task
    /// definition to run in your service. If a `revision` isn't specified, the
    /// latest `ACTIVE` revision is used.
    ///
    /// A task definition must be specified if the service uses either the `ECS` or
    /// `CODE_DEPLOY` deployment controllers.
    ///
    /// For more information about deployment types, see [Amazon ECS deployment
    /// types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html).
    task_definition: ?[]const u8 = null,

    /// The configuration for a volume specified in the task definition as a volume
    /// that is configured at launch time. Currently, the only supported volume type
    /// is an Amazon EBS volume.
    volume_configurations: ?[]const ServiceVolumeConfiguration = null,

    /// The VPC Lattice configuration for the service being created.
    vpc_lattice_configurations: ?[]const VpcLatticeConfiguration = null,

    pub const json_field_names = .{
        .availability_zone_rebalancing = "availabilityZoneRebalancing",
        .capacity_provider_strategy = "capacityProviderStrategy",
        .client_token = "clientToken",
        .cluster = "cluster",
        .deployment_configuration = "deploymentConfiguration",
        .deployment_controller = "deploymentController",
        .desired_count = "desiredCount",
        .enable_ecs_managed_tags = "enableECSManagedTags",
        .enable_execute_command = "enableExecuteCommand",
        .health_check_grace_period_seconds = "healthCheckGracePeriodSeconds",
        .launch_type = "launchType",
        .load_balancers = "loadBalancers",
        .network_configuration = "networkConfiguration",
        .placement_constraints = "placementConstraints",
        .placement_strategy = "placementStrategy",
        .platform_version = "platformVersion",
        .propagate_tags = "propagateTags",
        .role = "role",
        .scheduling_strategy = "schedulingStrategy",
        .service_connect_configuration = "serviceConnectConfiguration",
        .service_name = "serviceName",
        .service_registries = "serviceRegistries",
        .tags = "tags",
        .task_definition = "taskDefinition",
        .volume_configurations = "volumeConfigurations",
        .vpc_lattice_configurations = "vpcLatticeConfigurations",
    };
};

pub const CreateServiceOutput = struct {
    /// The full description of your service following the create call.
    ///
    /// A service will return either a `capacityProviderStrategy` or `launchType`
    /// parameter, but not both, depending where one was specified when it was
    /// created.
    ///
    /// If a service is using the `ECS` deployment controller, the
    /// `deploymentController` and `taskSets` parameters will not be returned.
    ///
    /// if the service uses the `CODE_DEPLOY` deployment controller, the
    /// `deploymentController`, `taskSets` and `deployments` parameters will be
    /// returned, however the `deployments` parameter will be an empty list.
    service: ?Service = null,

    pub const json_field_names = .{
        .service = "service",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceInput, options: CallOptions) !CreateServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ecs");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.CreateService");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateServiceOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AttributeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .attribute_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BlockedException")) {
        return .{ .arena = arena, .kind = .{ .blocked_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsCapacityProviderException")) {
        return .{ .arena = arena, .kind = .{ .cluster_contains_capacity_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsContainerInstancesException")) {
        return .{ .arena = arena, .kind = .{ .cluster_contains_container_instances_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsServicesException")) {
        return .{ .arena = arena, .kind = .{ .cluster_contains_services_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsTasksException")) {
        return .{ .arena = arena, .kind = .{ .cluster_contains_tasks_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .cluster_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DaemonNotActiveException")) {
        return .{ .arena = arena, .kind = .{ .daemon_not_active_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DaemonNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .daemon_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingVersionException")) {
        return .{ .arena = arena, .kind = .{ .missing_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NamespaceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .namespace_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoUpdateAvailableException")) {
        return .{ .arena = arena, .kind = .{ .no_update_available_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformTaskDefinitionIncompatibilityException")) {
        return .{ .arena = arena, .kind = .{ .platform_task_definition_incompatibility_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformUnknownException")) {
        return .{ .arena = arena, .kind = .{ .platform_unknown_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceDeploymentNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .service_deployment_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceNotActiveException")) {
        return .{ .arena = arena, .kind = .{ .service_not_active_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .service_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetNotConnectedException")) {
        return .{ .arena = arena, .kind = .{ .target_not_connected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .target_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaskSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .task_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_feature_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpdateInProgressException")) {
        return .{ .arena = arena, .kind = .{ .update_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
