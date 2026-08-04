const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const AutoScalingGroupProvider = @import("auto_scaling_group_provider.zig").AutoScalingGroupProvider;
const CreateManagedInstancesProviderConfiguration = @import("create_managed_instances_provider_configuration.zig").CreateManagedInstancesProviderConfiguration;
const Tag = @import("tag.zig").Tag;
const CapacityProvider = @import("capacity_provider.zig").CapacityProvider;

pub const CreateCapacityProviderInput = struct {
    /// The details of the Auto Scaling group for the capacity provider.
    auto_scaling_group_provider: ?AutoScalingGroupProvider = null,

    /// The name of the cluster to associate with the capacity provider. When you
    /// create a capacity provider with Amazon ECS Managed Instances, it becomes
    /// available only within the specified cluster.
    cluster: ?[]const u8 = null,

    /// The configuration for the Amazon ECS Managed Instances provider. This
    /// configuration specifies how Amazon ECS manages Amazon EC2 instances on your
    /// behalf, including the infrastructure role, instance launch template, and tag
    /// propagation settings.
    managed_instances_provider: ?CreateManagedInstancesProviderConfiguration = null,

    /// The name of the capacity provider. Up to 255 characters are allowed. They
    /// include letters (both upper and lowercase letters), numbers, underscores
    /// (_), and hyphens (-). The name can't be prefixed with "`aws`", "`ecs`", or
    /// "`fargate`".
    name: []const u8,

    /// The metadata that you apply to the capacity provider to categorize and
    /// organize them more conveniently. Each tag consists of a key and an optional
    /// value. You define both of them.
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

    pub const json_field_names = .{
        .auto_scaling_group_provider = "autoScalingGroupProvider",
        .cluster = "cluster",
        .managed_instances_provider = "managedInstancesProvider",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateCapacityProviderOutput = struct {
    /// The full description of the new capacity provider.
    capacity_provider: ?CapacityProvider = null,

    pub const json_field_names = .{
        .capacity_provider = "capacityProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCapacityProviderInput, options: CallOptions) !CreateCapacityProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCapacityProviderInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.CreateCapacityProvider");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCapacityProviderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCapacityProviderOutput, body, allocator);
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
