const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const DaemonTaskDefinitionRevisionFilter = @import("daemon_task_definition_revision_filter.zig").DaemonTaskDefinitionRevisionFilter;
const SortOrder = @import("sort_order.zig").SortOrder;
const DaemonTaskDefinitionStatusFilter = @import("daemon_task_definition_status_filter.zig").DaemonTaskDefinitionStatusFilter;
const DaemonTaskDefinitionSummary = @import("daemon_task_definition_summary.zig").DaemonTaskDefinitionSummary;

pub const ListDaemonTaskDefinitionsInput = struct {
    /// The exact name of the daemon task definition family to filter results with.
    family: ?[]const u8 = null,

    /// The full family name to filter the `ListDaemonTaskDefinitions` results with.
    /// Specifying a `familyPrefix` limits the listed daemon task definitions to
    /// daemon task definition families that start with the `familyPrefix` string.
    family_prefix: ?[]const u8 = null,

    /// The maximum number of daemon task definition results that
    /// `ListDaemonTaskDefinitions` returned in paginated output. When this
    /// parameter is used, `ListDaemonTaskDefinitions` only returns `maxResults`
    /// results in a single page along with a `nextToken` response element. The
    /// remaining results of the initial request can be seen by sending another
    /// `ListDaemonTaskDefinitions` request with the returned `nextToken` value.
    /// This value can be between 1 and 100. If this parameter isn't used, then
    /// `ListDaemonTaskDefinitions` returns up to 100 results and a `nextToken`
    /// value if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a `ListDaemonTaskDefinitions` request
    /// indicating that more results are available to fulfill the request and
    /// further calls will be needed. If `maxResults` was provided, it's possible
    /// for the number of results to be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The revision filter to apply. Specify `LAST_REGISTERED` to return only the
    /// last registered revision for each daemon task definition family.
    revision: ?DaemonTaskDefinitionRevisionFilter = null,

    /// The order to sort the results. Valid values are `ASC` and `DESC`. By default
    /// (`ASC`), daemon task definitions are listed in ascending order by family
    /// name and revision number.
    sort: ?SortOrder = null,

    /// The daemon task definition status to filter the `ListDaemonTaskDefinitions`
    /// results with. By default, only `ACTIVE` daemon task definitions are listed.
    /// If you set this parameter to `DELETE_IN_PROGRESS`, only daemon task
    /// definitions that are in the process of being deleted are listed. If you set
    /// this parameter to `ALL`, all daemon task definitions are listed regardless
    /// of status.
    status: ?DaemonTaskDefinitionStatusFilter = null,

    pub const json_field_names = .{
        .family = "family",
        .family_prefix = "familyPrefix",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .revision = "revision",
        .sort = "sort",
        .status = "status",
    };
};

pub const ListDaemonTaskDefinitionsOutput = struct {
    /// The list of daemon task definition summaries.
    daemon_task_definitions: ?[]const DaemonTaskDefinitionSummary = null,

    /// The `nextToken` value to include in a future `ListDaemonTaskDefinitions`
    /// request. When the results of a `ListDaemonTaskDefinitions` request exceed
    /// `maxResults`, this value can be used to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .daemon_task_definitions = "daemonTaskDefinitions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDaemonTaskDefinitionsInput, options: CallOptions) !ListDaemonTaskDefinitionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDaemonTaskDefinitionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListDaemonTaskDefinitions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDaemonTaskDefinitionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDaemonTaskDefinitionsOutput, body, allocator);
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
