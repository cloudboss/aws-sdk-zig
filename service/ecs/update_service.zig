const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AvailabilityZoneRebalancing = @import("availability_zone_rebalancing.zig").AvailabilityZoneRebalancing;
const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const DeploymentController = @import("deployment_controller.zig").DeploymentController;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const PlacementConstraint = @import("placement_constraint.zig").PlacementConstraint;
const PlacementStrategy = @import("placement_strategy.zig").PlacementStrategy;
const PropagateTags = @import("propagate_tags.zig").PropagateTags;
const ServiceConnectConfiguration = @import("service_connect_configuration.zig").ServiceConnectConfiguration;
const ServiceRegistry = @import("service_registry.zig").ServiceRegistry;
const ServiceVolumeConfiguration = @import("service_volume_configuration.zig").ServiceVolumeConfiguration;
const VpcLatticeConfiguration = @import("vpc_lattice_configuration.zig").VpcLatticeConfiguration;
const Service = @import("service.zig").Service;

pub const UpdateServiceInput = struct {
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
    ///
    /// This parameter doesn't trigger a new service deployment.
    availability_zone_rebalancing: ?AvailabilityZoneRebalancing = null,

    /// The details of a capacity provider strategy. You can set a capacity provider
    /// when you
    /// create a cluster, run a task, or update a service.
    ///
    /// If you want to use Amazon ECS Managed Instances, you must use the
    /// `capacityProviderStrategy` request parameter.
    ///
    /// When you use Fargate, the capacity providers are `FARGATE` or
    /// `FARGATE_SPOT`.
    ///
    /// When you use Amazon EC2, the capacity providers are Auto Scaling groups.
    ///
    /// You can change capacity providers for rolling deployments and blue/green
    /// deployments.
    ///
    /// The following list provides the valid transitions:
    ///
    /// * Update the Fargate launch type to an Auto Scaling group capacity
    /// provider.
    ///
    /// * Update the Amazon EC2 launch type to a Fargate capacity provider.
    ///
    /// * Update the Fargate capacity provider to an Auto Scaling group capacity
    /// provider.
    ///
    /// * Update the Amazon EC2 capacity provider to a Fargate capacity provider.
    ///
    /// * Update the Auto Scaling group or Fargate capacity provider back to the
    ///   launch
    /// type.
    ///
    /// Pass an empty list in the `capacityProviderStrategy`
    /// parameter.
    ///
    /// For information about Amazon Web Services CDK considerations, see [Amazon
    /// Web
    /// Services CDK
    /// considerations](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/update-service-parameters.html).
    ///
    /// This parameter doesn't trigger a new service deployment.
    capacity_provider_strategy: ?[]const CapacityProviderStrategyItem = null,

    /// The short name or full Amazon Resource Name (ARN) of the cluster that your
    /// service
    /// runs on. If you do not specify a cluster, the default cluster is assumed.
    ///
    /// You can't change the cluster name.
    cluster: ?[]const u8 = null,

    /// Optional deployment parameters that control how many tasks run during the
    /// deployment
    /// and the ordering of stopping and starting tasks.
    ///
    /// This parameter doesn't trigger a new service deployment.
    deployment_configuration: ?DeploymentConfiguration = null,

    deployment_controller: ?DeploymentController = null,

    /// The number of instantiations of the task to place and keep running in your
    /// service.
    ///
    /// This parameter doesn't trigger a new service deployment.
    desired_count: ?i32 = null,

    /// Determines whether to turn on Amazon ECS managed tags for the tasks in the
    /// service.
    /// For more information, see [Tagging Your Amazon ECS
    /// Resources](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-using-tags.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    ///
    /// Only tasks launched after the update will reflect the update. To update the
    /// tags on
    /// all tasks, set `forceNewDeployment` to `true`, so that Amazon ECS
    /// starts new tasks with the updated tags.
    ///
    /// This parameter doesn't trigger a new service deployment.
    enable_ecs_managed_tags: ?bool = null,

    /// If `true`, this enables execute command functionality on all task
    /// containers.
    ///
    /// If you do not want to override the value that was set when the service was
    /// created,
    /// you can set this to `null` when performing this action.
    ///
    /// This parameter doesn't trigger a new service deployment.
    enable_execute_command: ?bool = null,

    /// Determines whether to force a new deployment of the service. By default,
    /// deployments
    /// aren't forced. You can use this option to start a new deployment with no
    /// service
    /// definition changes. For example, you can update a service's tasks to use a
    /// newer Docker
    /// image with the same image/tag combination (`my_image:latest`) or to roll
    /// Fargate tasks onto a newer platform version.
    force_new_deployment: ?bool = null,

    /// The period of time, in seconds, that the Amazon ECS service scheduler
    /// ignores
    /// unhealthy Elastic Load Balancing, VPC Lattice, and container health checks
    /// after a task
    /// has first started. If you don't specify a health check grace period value,
    /// the default
    /// value of `0` is used. If you don't use any of the health checks, then
    /// `healthCheckGracePeriodSeconds` is unused.
    ///
    /// If your service's tasks take a while to start and respond to health checks,
    /// you can
    /// specify a health check grace period of up to 2,147,483,647 seconds (about 69
    /// years).
    /// During that time, the Amazon ECS service scheduler ignores health check
    /// status. This
    /// grace period can prevent the service scheduler from marking tasks as
    /// unhealthy and
    /// stopping them before they have time to come up.
    ///
    /// If your service has more running tasks than desired, unhealthy tasks in the
    /// grace
    /// period might be stopped to reach the desired count.
    ///
    /// This parameter doesn't trigger a new service deployment.
    health_check_grace_period_seconds: ?i32 = null,

    /// You must have a service-linked role when you update this property
    ///
    /// A list of Elastic Load Balancing load balancer objects. It contains the load
    /// balancer
    /// name, the container name, and the container port to access from the load
    /// balancer. The
    /// container name is as it appears in a container definition.
    ///
    /// When you add, update, or remove a load balancer configuration, Amazon ECS
    /// starts new
    /// tasks with the updated Elastic Load Balancing configuration, and then stops
    /// the old
    /// tasks when the new tasks are running.
    ///
    /// For services that use rolling updates, you can add, update, or remove
    /// Elastic Load
    /// Balancing target groups. You can update from a single target group to
    /// multiple target
    /// groups and from multiple target groups to a single target group.
    ///
    /// For services that use blue/green deployments, you can update Elastic Load
    /// Balancing
    /// target groups by using `
    /// [CreateDeployment](https://docs.aws.amazon.com/codedeploy/latest/APIReference/API_CreateDeployment.html)
    /// ` through CodeDeploy. Note that multiple target groups
    /// are not supported for blue/green deployments. For more information see
    /// [Register
    /// multiple target groups with a
    /// service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/register-multiple-targetgroups.html) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    ///
    /// For services that use the external deployment controller, you can add,
    /// update, or
    /// remove load balancers by using
    /// [CreateTaskSet](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateTaskSet.html).
    /// Note that multiple target groups are not supported for external deployments.
    /// For more
    /// information see [Register
    /// multiple target groups with a
    /// service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/register-multiple-targetgroups.html) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    ///
    /// You can remove existing `loadBalancers` by passing an empty list.
    ///
    /// This parameter triggers a new service deployment.
    load_balancers: ?[]const LoadBalancer = null,

    /// An object representing the network configuration for the service.
    ///
    /// This parameter triggers a new service deployment.
    network_configuration: ?NetworkConfiguration = null,

    /// An array of task placement constraint objects to update the service to use.
    /// If no
    /// value is specified, the existing placement constraints for the service will
    /// remain
    /// unchanged. If this value is specified, it will override any existing
    /// placement
    /// constraints defined for the service. To remove all existing placement
    /// constraints,
    /// specify an empty array.
    ///
    /// You can specify a maximum of 10 constraints for each task. This limit
    /// includes
    /// constraints in the task definition and those specified at runtime.
    ///
    /// This parameter doesn't trigger a new service deployment.
    placement_constraints: ?[]const PlacementConstraint = null,

    /// The task placement strategy objects to update the service to use. If no
    /// value is
    /// specified, the existing placement strategy for the service will remain
    /// unchanged. If
    /// this value is specified, it will override the existing placement strategy
    /// defined for
    /// the service. To remove an existing placement strategy, specify an empty
    /// object.
    ///
    /// You can specify a maximum of five strategy rules for each service.
    ///
    /// This parameter doesn't trigger a new service deployment.
    placement_strategy: ?[]const PlacementStrategy = null,

    /// The platform version that your tasks in the service run on. A platform
    /// version is only
    /// specified for tasks using the Fargate launch type. If a platform version is
    /// not
    /// specified, the `LATEST` platform version is used. For more information, see
    /// [Fargate
    /// Platform
    /// Versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service
    /// Developer Guide*.
    ///
    /// This parameter triggers a new service deployment.
    platform_version: ?[]const u8 = null,

    /// Determines whether to propagate the tags from the task definition or the
    /// service to
    /// the task. If no value is specified, the tags aren't propagated.
    ///
    /// Only tasks launched after the update will reflect the update. To update the
    /// tags on
    /// all tasks, set `forceNewDeployment` to `true`, so that Amazon ECS
    /// starts new tasks with the updated tags.
    ///
    /// This parameter doesn't trigger a new service deployment.
    propagate_tags: ?PropagateTags = null,

    /// The name of the service to update.
    service: []const u8,

    /// The configuration for this service to discover and connect to services, and
    /// be
    /// discovered by, and connected from, other services within a namespace.
    ///
    /// Tasks that run in a namespace can use short names to connect to services in
    /// the
    /// namespace. Tasks can connect to services across all of the clusters in the
    /// namespace.
    /// Tasks connect through a managed proxy container that collects logs and
    /// metrics for
    /// increased visibility. Only the tasks that Amazon ECS services create are
    /// supported with
    /// Service Connect. For more information, see [Service
    /// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html)
    /// in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// This parameter triggers a new service deployment.
    service_connect_configuration: ?ServiceConnectConfiguration = null,

    /// You must have a service-linked role when you update this property.
    ///
    /// For more information about the role see the `CreateService` request
    /// parameter [
    /// `role`
    /// ](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateService.html#ECS-CreateService-request-role).
    ///
    /// The details for the service discovery registries to assign to this service.
    /// For more
    /// information, see [Service
    /// Discovery](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-discovery.html).
    ///
    /// When you add, update, or remove the service registries configuration, Amazon
    /// ECS
    /// starts new tasks with the updated service registries configuration, and then
    /// stops the
    /// old tasks when the new tasks are running.
    ///
    /// You can remove existing `serviceRegistries` by passing an empty
    /// list.
    ///
    /// This parameter triggers a new service deployment.
    service_registries: ?[]const ServiceRegistry = null,

    /// The `family` and `revision` (`family:revision`) or
    /// full ARN of the task definition to run in your service. If a `revision` is
    /// not specified, the latest `ACTIVE` revision is used. If you modify the task
    /// definition with `UpdateService`, Amazon ECS spawns a task with the new
    /// version of the task definition and then stops an old task after the new
    /// version is
    /// running.
    ///
    /// This parameter triggers a new service deployment.
    task_definition: ?[]const u8 = null,

    /// The details of the volume that was `configuredAtLaunch`. You can configure
    /// the size, volumeType, IOPS, throughput, snapshot and encryption in
    /// [ServiceManagedEBSVolumeConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ServiceManagedEBSVolumeConfiguration.html). The `name` of the volume
    /// must match the `name` from the task definition. If set to null, no new
    /// deployment is triggered. Otherwise, if this configuration differs from the
    /// existing one,
    /// it triggers a new deployment.
    ///
    /// This parameter triggers a new service deployment.
    volume_configurations: ?[]const ServiceVolumeConfiguration = null,

    /// An object representing the VPC Lattice configuration for the service being
    /// updated.
    ///
    /// This parameter triggers a new service deployment.
    vpc_lattice_configurations: ?[]const VpcLatticeConfiguration = null,

    pub const json_field_names = .{
        .availability_zone_rebalancing = "availabilityZoneRebalancing",
        .capacity_provider_strategy = "capacityProviderStrategy",
        .cluster = "cluster",
        .deployment_configuration = "deploymentConfiguration",
        .deployment_controller = "deploymentController",
        .desired_count = "desiredCount",
        .enable_ecs_managed_tags = "enableECSManagedTags",
        .enable_execute_command = "enableExecuteCommand",
        .force_new_deployment = "forceNewDeployment",
        .health_check_grace_period_seconds = "healthCheckGracePeriodSeconds",
        .load_balancers = "loadBalancers",
        .network_configuration = "networkConfiguration",
        .placement_constraints = "placementConstraints",
        .placement_strategy = "placementStrategy",
        .platform_version = "platformVersion",
        .propagate_tags = "propagateTags",
        .service = "service",
        .service_connect_configuration = "serviceConnectConfiguration",
        .service_registries = "serviceRegistries",
        .task_definition = "taskDefinition",
        .volume_configurations = "volumeConfigurations",
        .vpc_lattice_configurations = "vpcLatticeConfigurations",
    };
};

pub const UpdateServiceOutput = struct {
    /// The full description of your service following the update call.
    service: ?Service = null,

    pub const json_field_names = .{
        .service = "service",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceInput, options: Options) !UpdateServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ecs");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.UpdateService");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateServiceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateServiceOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
