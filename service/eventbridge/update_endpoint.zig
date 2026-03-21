const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EndpointEventBus = @import("endpoint_event_bus.zig").EndpointEventBus;
const ReplicationConfig = @import("replication_config.zig").ReplicationConfig;
const RoutingConfig = @import("routing_config.zig").RoutingConfig;
const EndpointState = @import("endpoint_state.zig").EndpointState;

pub const UpdateEndpointInput = struct {
    /// A description for the endpoint.
    description: ?[]const u8 = null,

    /// Define event buses used for replication.
    event_buses: ?[]const EndpointEventBus = null,

    /// The name of the endpoint you want to update.
    name: []const u8,

    /// Whether event replication was enabled or disabled by this request.
    replication_config: ?ReplicationConfig = null,

    /// The ARN of the role used by event replication for this request.
    role_arn: ?[]const u8 = null,

    /// Configure the routing policy, including the health check and secondary
    /// Region.
    routing_config: ?RoutingConfig = null,

    pub const json_field_names = .{
        .description = "Description",
        .event_buses = "EventBuses",
        .name = "Name",
        .replication_config = "ReplicationConfig",
        .role_arn = "RoleArn",
        .routing_config = "RoutingConfig",
    };
};

pub const UpdateEndpointOutput = struct {
    /// The ARN of the endpoint you updated in this request.
    arn: ?[]const u8 = null,

    /// The ID of the endpoint you updated in this request.
    endpoint_id: ?[]const u8 = null,

    /// The URL of the endpoint you updated in this request.
    endpoint_url: ?[]const u8 = null,

    /// The event buses used for replication for the endpoint you updated in this
    /// request.
    event_buses: ?[]const EndpointEventBus = null,

    /// The name of the endpoint you updated in this request.
    name: ?[]const u8 = null,

    /// Whether event replication was enabled or disabled for the endpoint you
    /// updated in this
    /// request.
    replication_config: ?ReplicationConfig = null,

    /// The ARN of the role used by event replication for the endpoint you updated
    /// in this
    /// request.
    role_arn: ?[]const u8 = null,

    /// The routing configuration you updated in this request.
    routing_config: ?RoutingConfig = null,

    /// The state of the endpoint you updated in this request.
    state: ?EndpointState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .endpoint_id = "EndpointId",
        .endpoint_url = "EndpointUrl",
        .event_buses = "EventBuses",
        .name = "Name",
        .replication_config = "ReplicationConfig",
        .role_arn = "RoleArn",
        .routing_config = "RoutingConfig",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEndpointInput, options: CallOptions) !UpdateEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "events");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "EventBridge", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.UpdateEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEndpointOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalStatusException")) {
        return .{ .arena = arena, .kind = .{ .illegal_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventPatternException")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_pattern_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
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
    if (std.mem.eql(u8, error_code, "ManagedRuleException")) {
        return .{ .arena = arena, .kind = .{ .managed_rule_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationDisabledException")) {
        return .{ .arena = arena, .kind = .{ .operation_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
