const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const LaunchType = @import("launch_type.zig").LaunchType;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const TaskOverride = @import("task_override.zig").TaskOverride;
const PlacementConstraint = @import("placement_constraint.zig").PlacementConstraint;
const PlacementStrategy = @import("placement_strategy.zig").PlacementStrategy;
const PropagateTags = @import("propagate_tags.zig").PropagateTags;
const Tag = @import("tag.zig").Tag;
const TaskVolumeConfiguration = @import("task_volume_configuration.zig").TaskVolumeConfiguration;
const Failure = @import("failure.zig").Failure;
const Task = @import("task.zig").Task;

pub const RunTaskInput = struct {
    /// The capacity provider strategy to use for the task.
    ///
    /// If you want to use Amazon ECS Managed Instances, you must use the
    /// `capacityProviderStrategy` request parameter and omit the
    /// `launchType` request parameter.
    ///
    /// If a `capacityProviderStrategy` is specified, the `launchType`
    /// parameter must be omitted. If no `capacityProviderStrategy` or
    /// `launchType` is specified, the
    /// `defaultCapacityProviderStrategy` for the cluster is used.
    ///
    /// When you use cluster auto scaling, you must specify
    /// `capacityProviderStrategy` and not `launchType`.
    ///
    /// A capacity provider strategy can contain a maximum of 20 capacity providers.
    capacity_provider_strategy: ?[]const CapacityProviderStrategyItem = null,

    /// An identifier that you provide to ensure the idempotency of the request. It
    /// must be
    /// unique and is case sensitive. Up to 64 characters are allowed. The valid
    /// characters are
    /// characters in the range of 33-126, inclusive. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/ECS_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The short name or full Amazon Resource Name (ARN) of the cluster to run your
    /// task on.
    /// If you do not specify a cluster, the default cluster is assumed.
    ///
    /// Each account receives a default cluster the first time you use the service,
    /// but you
    /// may also create other clusters.
    cluster: ?[]const u8 = null,

    /// The number of instantiations of the specified task to place on your cluster.
    /// You can
    /// specify up to 10 tasks for each call.
    count: ?i32 = null,

    /// Specifies whether to use Amazon ECS managed tags for the task. For more
    /// information,
    /// see [Tagging Your Amazon ECS
    /// Resources](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-using-tags.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    enable_ecs_managed_tags: ?bool = null,

    /// Determines whether to use the execute command functionality for the
    /// containers in this
    /// task. If `true`, this enables execute command functionality on all
    /// containers
    /// in the task.
    ///
    /// If `true`, then the task definition must have a task role, or you must
    /// provide one as an override.
    enable_execute_command: ?bool = null,

    /// The name of the task group to associate with the task. The default value is
    /// the family
    /// name of the task definition (for example, `family:my-family-name`).
    group: ?[]const u8 = null,

    /// The infrastructure to run your standalone task on. For more information, see
    /// [Amazon
    /// ECS launch
    /// types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    ///
    /// If you want to use Amazon ECS Managed Instances, you must use the
    /// `capacityProviderStrategy` request parameter and omit the
    /// `launchType` request parameter.
    ///
    /// The `FARGATE` launch type runs your tasks on Fargate On-Demand
    /// infrastructure.
    ///
    /// Fargate Spot infrastructure is available for use but a capacity provider
    /// strategy
    /// must be used. For more information, see [Fargate capacity
    /// providers](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-capacity-providers.html) in
    /// the *Amazon ECS Developer Guide*.
    ///
    /// The `EC2` launch type runs your tasks on Amazon EC2 instances registered to
    /// your cluster.
    ///
    /// The `EXTERNAL` launch type runs your tasks on your on-premises server or
    /// virtual machine (VM) capacity registered to your cluster.
    ///
    /// A task can use either a launch type or a capacity provider strategy. If a
    /// `launchType` is specified, the `capacityProviderStrategy`
    /// parameter must be omitted.
    ///
    /// When you use cluster auto scaling, you must specify
    /// `capacityProviderStrategy` and not `launchType`.
    launch_type: ?LaunchType = null,

    /// The network configuration for the task. This parameter is required for task
    /// definitions that use the `awsvpc` network mode to receive their own elastic
    /// network interface, and it isn't supported for other network modes. For more
    /// information,
    /// see [Task
    /// networking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html)
    /// in the *Amazon Elastic Container Service Developer Guide*.
    network_configuration: ?NetworkConfiguration = null,

    /// A list of container overrides in JSON format that specify the name of a
    /// container in
    /// the specified task definition and the overrides it should receive. You can
    /// override the
    /// default command for a container (that's specified in the task definition or
    /// Docker
    /// image) with a `command` override. You can also override existing environment
    /// variables (that are specified in the task definition or Docker image) on a
    /// container or
    /// add new environment variables to it with an `environment` override.
    ///
    /// A total of 8192 characters are allowed for overrides. This limit includes
    /// the JSON
    /// formatting characters of the override structure.
    overrides: ?TaskOverride = null,

    /// An array of placement constraint objects to use for the task. You can
    /// specify up to 10
    /// constraints for each task (including constraints in the task definition and
    /// those
    /// specified at runtime).
    placement_constraints: ?[]const PlacementConstraint = null,

    /// The placement strategy objects to use for the task. You can specify a
    /// maximum of 5
    /// strategy rules for each task.
    placement_strategy: ?[]const PlacementStrategy = null,

    /// The platform version the task uses. A platform version is only specified for
    /// tasks
    /// hosted on Fargate. If one isn't specified, the `LATEST` platform version is
    /// used. For more information, see [Fargate
    /// platform
    /// versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service
    /// Developer Guide*.
    platform_version: ?[]const u8 = null,

    /// Specifies whether to propagate the tags from the task definition to the
    /// task. If no
    /// value is specified, the tags aren't propagated. Tags can only be propagated
    /// to the task
    /// during task creation. To add tags to a task after task creation, use
    /// the[TagResource](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_TagResource.html) API action.
    ///
    /// An error will be received if you specify the `SERVICE` option when
    /// running a task.
    propagate_tags: ?PropagateTags = null,

    /// This parameter is only used by Amazon ECS. It is not intended for use by
    /// customers.
    reference_id: ?[]const u8 = null,

    /// An optional tag specified when a task is started. For example, if you
    /// automatically
    /// trigger a task to run a batch process job, you could apply a unique
    /// identifier for that
    /// job to your task with the `startedBy` parameter. You can then identify which
    /// tasks belong to that job by filtering the results of a
    /// [ListTasks](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListTasks.html) call with
    /// the `startedBy` value. Up to 128 letters (uppercase and lowercase), numbers,
    /// hyphens (-), forward slash (/), and underscores (_) are allowed.
    ///
    /// If a task is started by an Amazon ECS service, then the `startedBy`
    /// parameter contains the deployment ID of the service that starts it.
    started_by: ?[]const u8 = null,

    /// The metadata that you apply to the task to help you categorize and organize
    /// them. Each
    /// tag consists of a key and an optional value, both of which you define.
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
    tags: ?[]const Tag = null,

    /// The `family` and `revision` (`family:revision`) or
    /// full ARN of the task definition to run. If a `revision` isn't specified, the
    /// latest `ACTIVE` revision is used.
    ///
    /// The full ARN value must match the value that you specified as the
    /// `Resource` of the principal's permissions policy.
    ///
    /// When you specify a task definition, you must either specify a specific
    /// revision, or
    /// all revisions in the ARN.
    ///
    /// To specify a specific revision, include the revision number in the ARN. For
    /// example,
    /// to specify revision 2, use
    /// `arn:aws:ecs:us-east-1:111122223333:task-definition/TaskFamilyName:2`.
    ///
    /// To specify all revisions, use the wildcard (*) in the ARN. For example, to
    /// specify all
    /// revisions, use
    /// `arn:aws:ecs:us-east-1:111122223333:task-definition/TaskFamilyName:*`.
    ///
    /// For more information, see [Policy Resources for Amazon
    /// ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/security_iam_service-with-iam.html#security_iam_service-with-iam-id-based-policies-resources) in the Amazon Elastic Container Service
    /// Developer Guide.
    task_definition: []const u8,

    /// The details of the volume that was `configuredAtLaunch`. You can configure
    /// the size, volumeType, IOPS, throughput, snapshot and encryption in
    /// [TaskManagedEBSVolumeConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_TaskManagedEBSVolumeConfiguration.html). The `name` of the volume must
    /// match the `name` from the task definition.
    volume_configurations: ?[]const TaskVolumeConfiguration = null,

    pub const json_field_names = .{
        .capacity_provider_strategy = "capacityProviderStrategy",
        .client_token = "clientToken",
        .cluster = "cluster",
        .count = "count",
        .enable_ecs_managed_tags = "enableECSManagedTags",
        .enable_execute_command = "enableExecuteCommand",
        .group = "group",
        .launch_type = "launchType",
        .network_configuration = "networkConfiguration",
        .overrides = "overrides",
        .placement_constraints = "placementConstraints",
        .placement_strategy = "placementStrategy",
        .platform_version = "platformVersion",
        .propagate_tags = "propagateTags",
        .reference_id = "referenceId",
        .started_by = "startedBy",
        .tags = "tags",
        .task_definition = "taskDefinition",
        .volume_configurations = "volumeConfigurations",
    };
};

pub const RunTaskOutput = struct {
    /// Any failures associated with the call.
    ///
    /// For information about how to address failures, see [Service event
    /// messages](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-event-messages.html#service-event-messages-list) and [API failure
    /// reasons](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/api_failures_messages.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    failures: ?[]const Failure = null,

    /// A full description of the tasks that were run. The tasks that were
    /// successfully placed
    /// on your cluster are described here.
    tasks: ?[]const Task = null,

    pub const json_field_names = .{
        .failures = "failures",
        .tasks = "tasks",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RunTaskInput, options: Options) !RunTaskOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RunTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.RunTask");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RunTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RunTaskOutput, body, alloc);
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
