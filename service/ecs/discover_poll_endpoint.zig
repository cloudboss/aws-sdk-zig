const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DiscoverPollEndpointInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster that the
    /// container instance belongs to.
    cluster: ?[]const u8 = null,

    /// The container instance ID or full ARN of the container instance. For more
    /// information about the ARN format, see [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-account-settings.html#ecs-resource-ids) in the *Amazon ECS Developer Guide*.
    container_instance: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .container_instance = "containerInstance",
    };
};

pub const DiscoverPollEndpointOutput = struct {
    /// The endpoint for the Amazon ECS agent to poll.
    endpoint: ?[]const u8 = null,

    /// The endpoint for the Amazon ECS agent to poll for Service Connect
    /// configuration. For more information, see [Service
    /// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.
    service_connect_endpoint: ?[]const u8 = null,

    /// The telemetry endpoint for the Amazon ECS agent.
    telemetry_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
        .service_connect_endpoint = "serviceConnectEndpoint",
        .telemetry_endpoint = "telemetryEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DiscoverPollEndpointInput, options: CallOptions) !DiscoverPollEndpointOutput {
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DiscoverPollEndpointInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DiscoverPollEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DiscoverPollEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DiscoverPollEndpointOutput, body, allocator);
}
