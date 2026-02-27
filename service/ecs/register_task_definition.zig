const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerDefinition = @import("container_definition.zig").ContainerDefinition;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const InferenceAccelerator = @import("inference_accelerator.zig").InferenceAccelerator;
const IpcMode = @import("ipc_mode.zig").IpcMode;
const NetworkMode = @import("network_mode.zig").NetworkMode;
const PidMode = @import("pid_mode.zig").PidMode;
const TaskDefinitionPlacementConstraint = @import("task_definition_placement_constraint.zig").TaskDefinitionPlacementConstraint;
const ProxyConfiguration = @import("proxy_configuration.zig").ProxyConfiguration;
const Compatibility = @import("compatibility.zig").Compatibility;
const RuntimePlatform = @import("runtime_platform.zig").RuntimePlatform;
const Tag = @import("tag.zig").Tag;
const Volume = @import("volume.zig").Volume;
const TaskDefinition = @import("task_definition.zig").TaskDefinition;

pub const RegisterTaskDefinitionInput = struct {
    /// A list of container definitions in JSON format that describe the different
    /// containers
    /// that make up your task.
    container_definitions: []const ContainerDefinition,

    /// The number of CPU units used by the task. It can be expressed as an integer
    /// using CPU
    /// units (for example, `1024`) or as a string using vCPUs (for example, `1
    /// vCPU` or `1 vcpu`) in a task definition. String values are
    /// converted to an integer indicating the CPU units when the task definition is
    /// registered.
    ///
    /// Task-level CPU and memory parameters are ignored for Windows containers. We
    /// recommend specifying container-level resources for Windows containers.
    ///
    /// If you're using the EC2 launch type or external launch type, this field is
    /// optional.
    /// Supported values are between `128` CPU units (`0.125` vCPUs) and
    /// `196608` CPU units (`192` vCPUs). If you do not specify a
    /// value, the parameter is ignored.
    ///
    /// This field is required for Fargate. For information about the valid values,
    /// see [Task
    /// size](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    cpu: ?[]const u8 = null,

    /// Enables fault injection when you register your task definition and allows
    /// for fault
    /// injection requests to be accepted from the task's containers. The default
    /// value is
    /// `false`.
    enable_fault_injection: ?bool = null,

    /// The amount of ephemeral storage to allocate for the task. This parameter is
    /// used to
    /// expand the total amount of ephemeral storage available, beyond the default
    /// amount, for
    /// tasks hosted on Fargate. For more information, see [Using data volumes in
    /// tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_data_volumes.html) in the *Amazon ECS Developer Guide*.
    ///
    /// For tasks using the Fargate launch type, the task requires the following
    /// platforms:
    ///
    /// * Linux platform version `1.4.0` or later.
    ///
    /// * Windows platform version `1.0.0` or later.
    ephemeral_storage: ?EphemeralStorage = null,

    /// The Amazon Resource Name (ARN) of the task execution role that grants the
    /// Amazon ECS
    /// container agent permission to make Amazon Web Services API calls on your
    /// behalf. For
    /// informationabout the required IAM roles for Amazon ECS, see [IAM roles
    /// for Amazon
    /// ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/security-ecs-iam-role-overview.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    execution_role_arn: ?[]const u8 = null,

    /// You must specify a `family` for a task definition. You can use it track
    /// multiple versions of the same task definition. The `family` is used as a
    /// name
    /// for your task definition. Up to 255 letters (uppercase and lowercase),
    /// numbers,
    /// underscores, and hyphens are allowed.
    family: []const u8,

    /// The Elastic Inference accelerators to use for the containers in the task.
    inference_accelerators: ?[]const InferenceAccelerator = null,

    /// The IPC resource namespace to use for the containers in the task. The valid
    /// values are
    /// `host`, `task`, or `none`. If `host` is
    /// specified, then all containers within the tasks that specified the `host`
    /// IPC
    /// mode on the same container instance share the same IPC resources with the
    /// host Amazon
    /// EC2 instance. If `task` is specified, all containers within the specified
    /// task share the same IPC resources. If `none` is specified, then IPC
    /// resources
    /// within the containers of a task are private and not shared with other
    /// containers in a
    /// task or on the container instance. If no value is specified, then the IPC
    /// resource
    /// namespace sharing depends on the Docker daemon setting on the container
    /// instance.
    ///
    /// If the `host` IPC mode is used, be aware that there is a heightened risk of
    /// undesired IPC namespace expose.
    ///
    /// If you are setting namespaced kernel parameters using `systemControls` for
    /// the containers in the task, the following will apply to your IPC resource
    /// namespace. For
    /// more information, see [System
    /// Controls](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    ///
    /// * For tasks that use the `host` IPC mode, IPC namespace related
    /// `systemControls` are not supported.
    ///
    /// * For tasks that use the `task` IPC mode, IPC namespace related
    /// `systemControls` will apply to all containers within a
    /// task.
    ///
    /// This parameter is not supported for Windows containers or tasks run on
    /// Fargate.
    ipc_mode: ?IpcMode = null,

    /// The amount of memory (in MiB) used by the task. It can be expressed as an
    /// integer
    /// using MiB (for example ,`1024`) or as a string using GB (for example,
    /// `1GB` or `1 GB`) in a task definition. String values are
    /// converted to an integer indicating the MiB when the task definition is
    /// registered.
    ///
    /// Task-level CPU and memory parameters are ignored for Windows containers. We
    /// recommend specifying container-level resources for Windows containers.
    ///
    /// If using the EC2 launch type, this field is optional.
    ///
    /// If using the Fargate launch type, this field is required and you must use
    /// one of the
    /// following values. This determines your range of supported values for the
    /// `cpu` parameter.
    ///
    /// The CPU units cannot be less than 1 vCPU when you use Windows containers on
    /// Fargate.
    ///
    /// * 512 (0.5 GB), 1024 (1 GB), 2048 (2 GB) - Available `cpu` values:
    /// 256 (.25 vCPU)
    ///
    /// * 1024 (1 GB), 2048 (2 GB), 3072 (3 GB), 4096 (4 GB) - Available
    /// `cpu` values: 512 (.5 vCPU)
    ///
    /// * 2048 (2 GB), 3072 (3 GB), 4096 (4 GB), 5120 (5 GB), 6144 (6 GB), 7168 (7
    ///   GB),
    /// 8192 (8 GB) - Available `cpu` values: 1024 (1 vCPU)
    ///
    /// * Between 4096 (4 GB) and 16384 (16 GB) in increments of 1024 (1 GB) -
    ///   Available
    /// `cpu` values: 2048 (2 vCPU)
    ///
    /// * Between 8192 (8 GB) and 30720 (30 GB) in increments of 1024 (1 GB) -
    ///   Available
    /// `cpu` values: 4096 (4 vCPU)
    ///
    /// * Between 16 GB and 60 GB in 4 GB increments - Available `cpu`
    /// values: 8192 (8 vCPU)
    ///
    /// This option requires Linux platform `1.4.0` or later.
    ///
    /// * Between 32GB and 120 GB in 8 GB increments - Available `cpu`
    /// values: 16384 (16 vCPU)
    ///
    /// This option requires Linux platform `1.4.0` or later.
    memory: ?[]const u8 = null,

    /// The Docker networking mode to use for the containers in the task. The valid
    /// values are
    /// `none`, `bridge`, `awsvpc`, and `host`.
    /// If no network mode is specified, the default is `bridge`.
    ///
    /// For Amazon ECS tasks on Fargate, the `awsvpc` network mode is required. For
    /// Amazon ECS tasks on Amazon EC2 Linux instances, any network mode can be
    /// used. For Amazon
    /// ECS tasks on Amazon EC2 Windows instances, `` or
    /// `awsvpc` can be used. If the network mode is set to `none`,
    /// you cannot specify port mappings in your container definitions, and the
    /// tasks containers
    /// do not have external connectivity. The `host` and `awsvpc` network
    /// modes offer the highest networking performance for containers because they
    /// use the EC2
    /// network stack instead of the virtualized network stack provided by the
    /// `bridge` mode.
    ///
    /// With the `host` and `awsvpc` network modes, exposed container
    /// ports are mapped directly to the corresponding host port (for the `host`
    /// network mode) or the attached elastic network interface port (for the
    /// `awsvpc` network mode), so you cannot take advantage of dynamic host port
    /// mappings.
    ///
    /// When using the `host` network mode, you should not run containers using
    /// the root user (UID 0). It is considered best practice to use a non-root
    /// user.
    ///
    /// If the network mode is `awsvpc`, the task is allocated an elastic network
    /// interface, and you must specify a
    /// [NetworkConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_NetworkConfiguration.html) value when you create a service or run a task with the
    /// task definition. For more information, see [Task
    /// Networking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html)
    /// in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// If the network mode is `host`, you cannot run multiple instantiations of
    /// the same task on a single container instance when port mappings are used.
    network_mode: ?NetworkMode = null,

    /// The process namespace to use for the containers in the task. The valid
    /// values are
    /// `host` or `task`. On Fargate for Linux containers, the only
    /// valid value is `task`. For example, monitoring sidecars might need
    /// `pidMode` to access information about other containers running in the
    /// same task.
    ///
    /// If `host` is specified, all containers within the tasks that specified the
    /// `host` PID mode on the same container instance share the same process
    /// namespace with the host Amazon EC2 instance.
    ///
    /// If `task` is specified, all containers within the specified task share the
    /// same process namespace.
    ///
    /// If no value is specified, the The default is a private namespace for each
    /// container.
    ///
    /// If the `host` PID mode is used, there's a heightened risk of undesired
    /// process namespace exposure.
    ///
    /// This parameter is not supported for Windows containers.
    ///
    /// This parameter is only supported for tasks that are hosted on Fargate if
    /// the tasks are using platform version `1.4.0` or later (Linux). This isn't
    /// supported for Windows containers on Fargate.
    pid_mode: ?PidMode = null,

    /// An array of placement constraint objects to use for the task. You can
    /// specify a
    /// maximum of 10 constraints for each task. This limit includes constraints in
    /// the task
    /// definition and those specified at runtime.
    placement_constraints: ?[]const TaskDefinitionPlacementConstraint = null,

    /// The configuration details for the App Mesh proxy.
    ///
    /// For tasks hosted on Amazon EC2 instances, the container instances require at
    /// least
    /// version `1.26.0` of the container agent and at least version
    /// `1.26.0-1` of the `ecs-init` package to use a proxy
    /// configuration. If your container instances are launched from the Amazon
    /// ECS-optimized
    /// AMI version `20190301` or later, then they contain the required versions of
    /// the container agent and `ecs-init`. For more information, see [Amazon
    /// ECS-optimized AMI
    /// versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-ami-versions.html) in the *Amazon Elastic Container
    /// Service Developer Guide*.
    proxy_configuration: ?ProxyConfiguration = null,

    /// The task launch type that Amazon ECS validates the task definition against.
    /// A client
    /// exception is returned if the task definition doesn't validate against the
    /// compatibilities specified. If no value is specified, the parameter is
    /// omitted from the
    /// response.
    requires_compatibilities: ?[]const Compatibility = null,

    /// The operating system that your tasks definitions run on.
    runtime_platform: ?RuntimePlatform = null,

    /// The metadata that you apply to the task definition to help you categorize
    /// and organize
    /// them. Each tag consists of a key and an optional value. You define both of
    /// them.
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

    /// The short name or full Amazon Resource Name (ARN) of the IAM role that
    /// containers in
    /// this task can assume. All containers in this task are granted the
    /// permissions that are
    /// specified in this role. For more information, see [IAM Roles for
    /// Tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    task_role_arn: ?[]const u8 = null,

    /// A list of volume definitions in JSON format that containers in your task
    /// might
    /// use.
    volumes: ?[]const Volume = null,

    pub const json_field_names = .{
        .container_definitions = "containerDefinitions",
        .cpu = "cpu",
        .enable_fault_injection = "enableFaultInjection",
        .ephemeral_storage = "ephemeralStorage",
        .execution_role_arn = "executionRoleArn",
        .family = "family",
        .inference_accelerators = "inferenceAccelerators",
        .ipc_mode = "ipcMode",
        .memory = "memory",
        .network_mode = "networkMode",
        .pid_mode = "pidMode",
        .placement_constraints = "placementConstraints",
        .proxy_configuration = "proxyConfiguration",
        .requires_compatibilities = "requiresCompatibilities",
        .runtime_platform = "runtimePlatform",
        .tags = "tags",
        .task_role_arn = "taskRoleArn",
        .volumes = "volumes",
    };
};

pub const RegisterTaskDefinitionOutput = struct {
    /// The list of tags associated with the task definition.
    tags: ?[]const Tag = null,

    /// The full description of the registered task definition.
    task_definition: ?TaskDefinition = null,

    pub const json_field_names = .{
        .tags = "tags",
        .task_definition = "taskDefinition",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterTaskDefinitionInput, options: Options) !RegisterTaskDefinitionOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RegisterTaskDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.RegisterTaskDefinition");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RegisterTaskDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterTaskDefinitionOutput, body, alloc);
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
