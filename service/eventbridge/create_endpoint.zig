const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointEventBus = @import("endpoint_event_bus.zig").EndpointEventBus;
const ReplicationConfig = @import("replication_config.zig").ReplicationConfig;
const RoutingConfig = @import("routing_config.zig").RoutingConfig;
const EndpointState = @import("endpoint_state.zig").EndpointState;

pub const CreateEndpointInput = struct {
    /// A description of the global endpoint.
    description: ?[]const u8 = null,

    /// Define the event buses used.
    ///
    /// The names of the event buses must be identical in each Region.
    event_buses: []const EndpointEventBus,

    /// The name of the global endpoint. For example,
    /// `"Name":"us-east-2-custom_bus_A-endpoint"`.
    name: []const u8,

    /// Enable or disable event replication. The default state is `ENABLED` which
    /// means
    /// you must supply a `RoleArn`. If you don't have a `RoleArn` or you don't
    /// want event replication enabled, set the state to `DISABLED`.
    replication_config: ?ReplicationConfig = null,

    /// The ARN of the role used for replication.
    role_arn: ?[]const u8 = null,

    /// Configure the routing policy, including the health check and secondary
    /// Region..
    routing_config: RoutingConfig,

    pub const json_field_names = .{
        .description = "Description",
        .event_buses = "EventBuses",
        .name = "Name",
        .replication_config = "ReplicationConfig",
        .role_arn = "RoleArn",
        .routing_config = "RoutingConfig",
    };
};

pub const CreateEndpointOutput = struct {
    /// The ARN of the endpoint that was created by this request.
    arn: ?[]const u8 = null,

    /// The event buses used by this request.
    event_buses: ?[]const EndpointEventBus = null,

    /// The name of the endpoint that was created by this request.
    name: ?[]const u8 = null,

    /// Whether event replication was enabled or disabled by this request.
    replication_config: ?ReplicationConfig = null,

    /// The ARN of the role used by event replication for this request.
    role_arn: ?[]const u8 = null,

    /// The routing configuration defined by this request.
    routing_config: ?RoutingConfig = null,

    /// The state of the endpoint that was created by this request.
    state: ?EndpointState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .event_buses = "EventBuses",
        .name = "Name",
        .replication_config = "ReplicationConfig",
        .role_arn = "RoleArn",
        .routing_config = "RoutingConfig",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEndpointInput, options: CallOptions) !CreateEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEndpointInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.CreateEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEndpointOutput, body, allocator);
}
