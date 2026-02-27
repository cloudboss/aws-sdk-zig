const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SettingName = @import("setting_name.zig").SettingName;
const Setting = @import("setting.zig").Setting;

pub const PutAccountSettingInput = struct {
    /// The Amazon ECS account setting name to modify.
    ///
    /// The following are the valid values for the account setting name.
    ///
    /// * `serviceLongArnFormat` - When modified, the Amazon Resource Name
    /// (ARN) and resource ID format of the resource type for a specified user,
    /// role, or
    /// the root user for an account is affected. The opt-in and opt-out account
    /// setting
    /// must be set for each Amazon ECS resource separately. The ARN and resource ID
    /// format of a resource is defined by the opt-in status of the user or role
    /// that
    /// created the resource. You must turn on this setting to use Amazon ECS
    /// features
    /// such as resource tagging.
    ///
    /// * `taskLongArnFormat` - When modified, the Amazon Resource Name (ARN)
    /// and resource ID format of the resource type for a specified user, role, or
    /// the
    /// root user for an account is affected. The opt-in and opt-out account setting
    /// must be set for each Amazon ECS resource separately. The ARN and resource ID
    /// format of a resource is defined by the opt-in status of the user or role
    /// that
    /// created the resource. You must turn on this setting to use Amazon ECS
    /// features
    /// such as resource tagging.
    ///
    /// * `containerInstanceLongArnFormat` - When modified, the Amazon
    /// Resource Name (ARN) and resource ID format of the resource type for a
    /// specified
    /// user, role, or the root user for an account is affected. The opt-in and
    /// opt-out
    /// account setting must be set for each Amazon ECS resource separately. The ARN
    /// and
    /// resource ID format of a resource is defined by the opt-in status of the user
    /// or
    /// role that created the resource. You must turn on this setting to use Amazon
    /// ECS
    /// features such as resource tagging.
    ///
    /// * `awsvpcTrunking` - When modified, the elastic network interface
    /// (ENI) limit for any new container instances that support the feature is
    /// changed.
    /// If `awsvpcTrunking` is turned on, any new container instances that
    /// support the feature are launched have the increased ENI limits available to
    /// them. For more information, see [Elastic
    /// Network Interface
    /// Trunking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container-instance-eni.html) in the *Amazon Elastic Container
    /// Service Developer Guide*.
    ///
    /// * `containerInsights` - Container Insights with enhanced
    /// observability provides all the Container Insights metrics, plus additional
    /// task
    /// and container metrics. This version supports enhanced observability for
    /// Amazon
    /// ECS clusters using the Amazon EC2 and Fargate launch types. After you
    /// configure
    /// Container Insights with enhanced observability on Amazon ECS, Container
    /// Insights
    /// auto-collects detailed infrastructure telemetry from the cluster level down
    /// to
    /// the container level in your environment and displays these critical
    /// performance
    /// data in curated dashboards removing the heavy lifting in observability
    /// set-up.
    ///
    /// To use Container Insights with enhanced observability, set the
    /// `containerInsights` account setting to
    /// `enhanced`.
    ///
    /// To use Container Insights, set the `containerInsights` account
    /// setting to `enabled`.
    ///
    /// For more information, see [Monitor Amazon ECS containers using Container
    /// Insights with enhanced
    /// observability](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-container-insights.html) in the *Amazon Elastic Container Service
    /// Developer Guide*.
    ///
    /// * `dualStackIPv6` - When turned on, when using a VPC in dual stack
    /// mode, your tasks using the `awsvpc` network mode can have an IPv6
    /// address assigned. For more information on using IPv6 with tasks launched on
    /// Amazon EC2 instances, see [Using a VPC in dual-stack
    /// mode](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking-awsvpc.html#task-networking-vpc-dual-stack). For more information on using IPv6
    /// with tasks launched on Fargate, see [Using a VPC in dual-stack
    /// mode](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-task-networking.html#fargate-task-networking-vpc-dual-stack).
    ///
    /// * `fargateTaskRetirementWaitPeriod` - When Amazon Web Services
    /// determines that a security or infrastructure update is needed for an Amazon
    /// ECS
    /// task hosted on Fargate, the tasks need to be stopped and new tasks launched
    /// to
    /// replace them. Use `fargateTaskRetirementWaitPeriod` to configure the
    /// wait time to retire a Fargate task. For information about the Fargate tasks
    /// maintenance, see [Amazon Web
    /// Services Fargate task
    /// maintenance](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-maintenance.html) in the
    /// *Amazon ECS Developer Guide*.
    ///
    /// * `fargateEventWindows` - When
    /// Amazon Web Services
    /// determines that a security or infrastructure update is needed for an Amazon
    /// ECS
    /// task hosted on Fargate, the tasks need to be stopped and new tasks launched
    /// to
    /// replace them. Use `fargateEventWindows` to use EC2 Event Windows associated
    /// with Fargate tasks to configure time windows for task retirement.
    ///
    /// * `tagResourceAuthorization` - Amazon ECS is introducing tagging
    /// authorization for resource creation. Users must have permissions for actions
    /// that create the resource, such as `ecsCreateCluster`. If tags are
    /// specified when you create a resource, Amazon Web Services performs
    /// additional authorization to verify if users or roles have permissions to
    /// create
    /// tags. Therefore, you must grant explicit permissions to use the
    /// `ecs:TagResource` action. For more information, see [Grant permission to tag
    /// resources on
    /// creation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/supported-iam-actions-tagging.html) in the
    /// *Amazon ECS Developer Guide*.
    ///
    /// * `defaultLogDriverMode` - Amazon ECS supports setting a default
    /// delivery mode of log messages from a container to the `logDriver`
    /// that you specify in the container's `logConfiguration`. The delivery
    /// mode affects application stability when the flow of logs from the container
    /// to
    /// the log driver is interrupted. The `defaultLogDriverMode` setting
    /// supports two values: `blocking` and `non-blocking`. If you
    /// don't specify a delivery mode in your container definition's
    /// `logConfiguration`, the mode you specify using this account
    /// setting will be used as the default. For more information about log delivery
    /// modes, see
    /// [LogConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html).
    ///
    /// On June 25, 2025, Amazon ECS changed the default log driver mode from
    /// `blocking` to `non-blocking` to prioritize task
    /// availability over logging. To continue using the `blocking` mode
    /// after this change, do one of the following:
    ///
    /// * Set the `mode` option in your container definition's
    /// `logConfiguration` as `blocking`.
    ///
    /// * Set the `defaultLogDriverMode` account setting to
    /// `blocking`.
    ///
    /// * `guardDutyActivate` - The `guardDutyActivate` parameter
    /// is read-only in Amazon ECS and indicates whether Amazon ECS Runtime
    /// Monitoring
    /// is enabled or disabled by your security administrator in your Amazon ECS
    /// account. Amazon GuardDuty controls this account setting on your behalf. For
    /// more
    /// information, see [Protecting Amazon ECS workloads with Amazon ECS Runtime
    /// Monitoring](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-guard-duty-integration.html).
    name: SettingName,

    /// The ARN of the principal, which can be a user, role, or the root user. If
    /// you specify
    /// the root user, it modifies the account setting for all users, roles, and the
    /// root user
    /// of the account unless a user or role explicitly overrides these settings. If
    /// this field
    /// is omitted, the setting is changed only for the authenticated user.
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
    /// are
    /// `enabled`, `disabled`, `enhanced`, `on`,
    /// and `off`.
    ///
    /// When you specify `fargateTaskRetirementWaitPeriod` for the
    /// `name`, the following are the valid values:
    ///
    /// * `0` - Amazon Web Services sends the notification, and
    /// immediately retires the affected tasks.
    ///
    /// * `7` - Amazon Web Services sends the notification, and waits 7
    /// calendar days to retire the tasks.
    ///
    /// * `14` - Amazon Web Services sends the notification, and waits 14
    /// calendar days to retire the tasks.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccountSettingInput, options: Options) !PutAccountSettingOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: PutAccountSettingInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.PutAccountSetting");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutAccountSettingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutAccountSettingOutput, body, alloc);
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
