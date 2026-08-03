const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const SettingName = @import("setting_name.zig").SettingName;
const Setting = @import("setting.zig").Setting;

pub const PutAccountSettingInput = struct {
    /// The Amazon ECS account setting name to modify.
    ///
    /// The following are the valid values for the account setting name.
    ///
    /// * `serviceLongArnFormat` - When modified, the Amazon Resource Name (ARN) and
    ///   resource ID format of the resource type for a specified user, role, or the
    ///   root user for an account is affected. The opt-in and opt-out account
    ///   setting must be set for each Amazon ECS resource separately. The ARN and
    ///   resource ID format of a resource is defined by the opt-in status of the
    ///   user or role that created the resource. You must turn on this setting to
    ///   use Amazon ECS features such as resource tagging.
    /// * `taskLongArnFormat` - When modified, the Amazon Resource Name (ARN) and
    ///   resource ID format of the resource type for a specified user, role, or the
    ///   root user for an account is affected. The opt-in and opt-out account
    ///   setting must be set for each Amazon ECS resource separately. The ARN and
    ///   resource ID format of a resource is defined by the opt-in status of the
    ///   user or role that created the resource. You must turn on this setting to
    ///   use Amazon ECS features such as resource tagging.
    /// * `containerInstanceLongArnFormat` - When modified, the Amazon Resource Name
    ///   (ARN) and resource ID format of the resource type for a specified user,
    ///   role, or the root user for an account is affected. The opt-in and opt-out
    ///   account setting must be set for each Amazon ECS resource separately. The
    ///   ARN and resource ID format of a resource is defined by the opt-in status
    ///   of the user or role that created the resource. You must turn on this
    ///   setting to use Amazon ECS features such as resource tagging.
    /// * `awsvpcTrunking` - When modified, the elastic network interface (ENI)
    ///   limit for any new container instances that support the feature is changed.
    ///   If `awsvpcTrunking` is turned on, any new container instances that support
    ///   the feature are launched have the increased ENI limits available to them.
    ///   For more information, see [Elastic Network Interface
    ///   Trunking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container-instance-eni.html) in the *Amazon Elastic Container Service Developer Guide*.
    /// * `containerInsights` - Container Insights with enhanced observability
    ///   provides all the Container Insights metrics, plus additional task and
    ///   container metrics. This version supports enhanced observability for Amazon
    ///   ECS clusters using the Amazon EC2 and Fargate launch types. After you
    ///   configure Container Insights with enhanced observability on Amazon ECS,
    ///   Container Insights auto-collects detailed infrastructure telemetry from
    ///   the cluster level down to the container level in your environment and
    ///   displays these critical performance data in curated dashboards removing
    ///   the heavy lifting in observability set-up.
    ///
    /// To use Container Insights with enhanced observability, set the
    /// `containerInsights` account setting to `enhanced`.
    ///
    /// To use Container Insights, set the `containerInsights` account setting to
    /// `enabled`.
    ///
    /// For more information, see [Monitor Amazon ECS containers using Container
    /// Insights with enhanced
    /// observability](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-container-insights.html) in the *Amazon Elastic Container Service Developer Guide*.
    /// * `dualStackIPv6` - When turned on, when using a VPC in dual stack mode,
    ///   your tasks using the `awsvpc` network mode can have an IPv6 address
    ///   assigned. For more information on using IPv6 with tasks launched on Amazon
    ///   EC2 instances, see [Using a VPC in dual-stack
    ///   mode](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking-awsvpc.html#task-networking-vpc-dual-stack). For more information on using IPv6 with tasks launched on Fargate, see [Using a VPC in dual-stack mode](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-task-networking.html#fargate-task-networking-vpc-dual-stack).
    /// * `fargateTaskRetirementWaitPeriod` - When Amazon Web Services determines
    ///   that a security or infrastructure update is needed for an Amazon ECS task
    ///   hosted on Fargate, the tasks need to be stopped and new tasks launched to
    ///   replace them. Use `fargateTaskRetirementWaitPeriod` to configure the wait
    ///   time to retire a Fargate task. For information about the Fargate tasks
    ///   maintenance, see [Amazon Web Services Fargate task
    ///   maintenance](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-maintenance.html) in the *Amazon ECS Developer Guide*.
    /// * `fargateEventWindows` - When Amazon Web Services determines that a
    ///   security or infrastructure update is needed for an Amazon ECS task hosted
    ///   on Fargate, the tasks need to be stopped and new tasks launched to replace
    ///   them. Use `fargateEventWindows` to use EC2 Event Windows associated with
    ///   Fargate tasks to configure time windows for task retirement.
    /// * `tagResourceAuthorization` - Amazon ECS is introducing tagging
    ///   authorization for resource creation. Users must have permissions for
    ///   actions that create the resource, such as `ecsCreateCluster`. If tags are
    ///   specified when you create a resource, Amazon Web Services performs
    ///   additional authorization to verify if users or roles have permissions to
    ///   create tags. Therefore, you must grant explicit permissions to use the
    ///   `ecs:TagResource` action. For more information, see [Grant permission to
    ///   tag resources on
    ///   creation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/supported-iam-actions-tagging.html) in the *Amazon ECS Developer Guide*.
    /// * `defaultLogDriverMode` - Amazon ECS supports setting a default delivery
    ///   mode of log messages from a container to the `logDriver` that you specify
    ///   in the container's `logConfiguration`. The delivery mode affects
    ///   application stability when the flow of logs from the container to the log
    ///   driver is interrupted. The `defaultLogDriverMode` setting supports two
    ///   values: `blocking` and `non-blocking`. If you don't specify a delivery
    ///   mode in your container definition's `logConfiguration`, the mode you
    ///   specify using this account setting will be used as the default. For more
    ///   information about log delivery modes, see
    ///   [LogConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html).
    ///
    /// On June 25, 2025, Amazon ECS changed the default log driver mode from
    /// `blocking` to `non-blocking` to prioritize task availability over logging.
    /// To continue using the `blocking` mode after this change, do one of the
    /// following:
    ///
    /// * Set the `mode` option in your container definition's `logConfiguration` as
    ///   `blocking`.
    /// * Set the `defaultLogDriverMode` account setting to `blocking`.
    ///
    /// * `guardDutyActivate` - The `guardDutyActivate` parameter is read-only in
    ///   Amazon ECS and indicates whether Amazon ECS Runtime Monitoring is enabled
    ///   or disabled by your security administrator in your Amazon ECS account.
    ///   Amazon GuardDuty controls this account setting on your behalf. For more
    ///   information, see [Protecting Amazon ECS workloads with Amazon ECS Runtime
    ///   Monitoring](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-guard-duty-integration.html).
    name: SettingName,

    /// The ARN of the principal, which can be a user, role, or the root user. If
    /// you specify the root user, it modifies the account setting for all users,
    /// roles, and the root user of the account unless a user or role explicitly
    /// overrides these settings. If this field is omitted, the setting is changed
    /// only for the authenticated user.
    ///
    /// In order to use this parameter, you must be the root user, or the principal.
    ///
    /// You must use the root user when you set the Fargate wait time
    /// (`fargateTaskRetirementWaitPeriod`).
    ///
    /// Federated users assume the account setting of the root user and can't have
    /// explicit account settings set for them.
    principal_arn: ?[]const u8 = null,

    /// The account setting value for the specified principal ARN. Accepted values
    /// are `enabled`, `disabled`, `enhanced`, `on`, and `off`.
    ///
    /// When you specify `fargateTaskRetirementWaitPeriod` for the `name`, the
    /// following are the valid values:
    ///
    /// * `0` - Amazon Web Services sends the notification, and immediately retires
    ///   the affected tasks.
    /// * `7` - Amazon Web Services sends the notification, and waits 7 calendar
    ///   days to retire the tasks.
    /// * `14` - Amazon Web Services sends the notification, and waits 14 calendar
    ///   days to retire the tasks.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .principal_arn = "principalArn",
        .value = "value",
    };
};

pub const PutAccountSettingOutput = struct {
    /// The current account setting for a resource.
    setting: ?Setting = null,

    pub const json_field_names = .{
        .setting = "setting",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccountSettingInput, options: CallOptions) !PutAccountSettingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutAccountSettingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.PutAccountSetting");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAccountSettingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutAccountSettingOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttributeLimitExceededException")) {
        const parsed_error: ?errors.AttributeLimitExceededException = aws.json.parseJsonObject(errors.AttributeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attribute_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BlockedException")) {
        const parsed_error: ?errors.BlockedException = aws.json.parseJsonObject(errors.BlockedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .blocked_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClientException")) {
        const parsed_error: ?errors.ClientException = aws.json.parseJsonObject(errors.ClientException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .client_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsCapacityProviderException")) {
        const parsed_error: ?errors.ClusterContainsCapacityProviderException = aws.json.parseJsonObject(errors.ClusterContainsCapacityProviderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_contains_capacity_provider_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsContainerInstancesException")) {
        const parsed_error: ?errors.ClusterContainsContainerInstancesException = aws.json.parseJsonObject(errors.ClusterContainsContainerInstancesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_contains_container_instances_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsServicesException")) {
        const parsed_error: ?errors.ClusterContainsServicesException = aws.json.parseJsonObject(errors.ClusterContainsServicesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_contains_services_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsTasksException")) {
        const parsed_error: ?errors.ClusterContainsTasksException = aws.json.parseJsonObject(errors.ClusterContainsTasksException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_contains_tasks_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterNotFoundException")) {
        const parsed_error: ?errors.ClusterNotFoundException = aws.json.parseJsonObject(errors.ClusterNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DaemonNotActiveException")) {
        const parsed_error: ?errors.DaemonNotActiveException = aws.json.parseJsonObject(errors.DaemonNotActiveException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .daemon_not_active_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DaemonNotFoundException")) {
        const parsed_error: ?errors.DaemonNotFoundException = aws.json.parseJsonObject(errors.DaemonNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .daemon_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        const parsed_error: ?errors.InvalidParameterException = aws.json.parseJsonObject(errors.InvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MissingVersionException")) {
        const parsed_error: ?errors.MissingVersionException = aws.json.parseJsonObject(errors.MissingVersionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .missing_version_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NamespaceNotFoundException")) {
        const parsed_error: ?errors.NamespaceNotFoundException = aws.json.parseJsonObject(errors.NamespaceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .namespace_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoUpdateAvailableException")) {
        const parsed_error: ?errors.NoUpdateAvailableException = aws.json.parseJsonObject(errors.NoUpdateAvailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_update_available_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PlatformTaskDefinitionIncompatibilityException")) {
        const parsed_error: ?errors.PlatformTaskDefinitionIncompatibilityException = aws.json.parseJsonObject(errors.PlatformTaskDefinitionIncompatibilityException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .platform_task_definition_incompatibility_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PlatformUnknownException")) {
        const parsed_error: ?errors.PlatformUnknownException = aws.json.parseJsonObject(errors.PlatformUnknownException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .platform_unknown_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?errors.ResourceInUseException = aws.json.parseJsonObject(errors.ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        const parsed_error: ?errors.ServerException = aws.json.parseJsonObject(errors.ServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceDeploymentNotFoundException")) {
        const parsed_error: ?errors.ServiceDeploymentNotFoundException = aws.json.parseJsonObject(errors.ServiceDeploymentNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_deployment_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceNotActiveException")) {
        const parsed_error: ?errors.ServiceNotActiveException = aws.json.parseJsonObject(errors.ServiceNotActiveException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_not_active_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceNotFoundException")) {
        const parsed_error: ?errors.ServiceNotFoundException = aws.json.parseJsonObject(errors.ServiceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetNotConnectedException")) {
        const parsed_error: ?errors.TargetNotConnectedException = aws.json.parseJsonObject(errors.TargetNotConnectedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_not_connected_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetNotFoundException")) {
        const parsed_error: ?errors.TargetNotFoundException = aws.json.parseJsonObject(errors.TargetNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TaskSetNotFoundException")) {
        const parsed_error: ?errors.TaskSetNotFoundException = aws.json.parseJsonObject(errors.TaskSetNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .task_set_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureException")) {
        const parsed_error: ?errors.UnsupportedFeatureException = aws.json.parseJsonObject(errors.UnsupportedFeatureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_feature_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UpdateInProgressException")) {
        const parsed_error: ?errors.UpdateInProgressException = aws.json.parseJsonObject(errors.UpdateInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .update_in_progress_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
