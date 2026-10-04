const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointEventBus = @import("endpoint_event_bus.zig").EndpointEventBus;
const ReplicationConfig = @import("replication_config.zig").ReplicationConfig;
const RoutingConfig = @import("routing_config.zig").RoutingConfig;
const EndpointState = @import("endpoint_state.zig").EndpointState;

pub const DescribeEndpointInput = struct {
    /// The primary Region of the endpoint you want to get information about. For
    /// example
    /// `"HomeRegion": "us-east-1"`.
    home_region: ?[]const u8 = null,

    /// The name of the endpoint you want to get information about. For example,
    /// `"Name":"us-east-2-custom_bus_A-endpoint"`.
    name: []const u8,

    pub const json_field_names = .{
        .home_region = "HomeRegion",
        .name = "Name",
    };
};

pub const DescribeEndpointOutput = struct {
    /// The ARN of the endpoint you asked for information about.
    arn: ?[]const u8 = null,

    /// The time the endpoint you asked for information about was created.
    creation_time: ?i64 = null,

    /// The description of the endpoint you asked for information about.
    description: ?[]const u8 = null,

    /// The ID of the endpoint you asked for information about.
    endpoint_id: ?[]const u8 = null,

    /// The URL of the endpoint you asked for information about.
    endpoint_url: ?[]const u8 = null,

    /// The event buses being used by the endpoint you asked for information about.
    event_buses: ?[]const EndpointEventBus = null,

    /// The last time the endpoint you asked for information about was modified.
    last_modified_time: ?i64 = null,

    /// The name of the endpoint you asked for information about.
    name: ?[]const u8 = null,

    /// Whether replication is enabled or disabled for the endpoint you asked for
    /// information
    /// about.
    replication_config: ?ReplicationConfig = null,

    /// The ARN of the role used by the endpoint you asked for information about.
    role_arn: ?[]const u8 = null,

    /// The routing configuration of the endpoint you asked for information about.
    routing_config: ?RoutingConfig = null,

    /// The current state of the endpoint you asked for information about.
    state: ?EndpointState = null,

    /// The reason the endpoint you asked for information about is in its current
    /// state.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .description = "Description",
        .endpoint_id = "EndpointId",
        .endpoint_url = "EndpointUrl",
        .event_buses = "EventBuses",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .replication_config = "ReplicationConfig",
        .role_arn = "RoleArn",
        .routing_config = "RoutingConfig",
        .state = "State",
        .state_reason = "StateReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEndpointInput, options: CallOptions) !DescribeEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "EventBridge", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DescribeEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEndpointOutput, body, allocator);
}
