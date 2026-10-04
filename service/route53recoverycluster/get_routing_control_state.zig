const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoutingControlState = @import("routing_control_state.zig").RoutingControlState;

pub const GetRoutingControlStateInput = struct {
    /// The Amazon Resource Name (ARN) for the routing control that you want to get
    /// the state for.
    routing_control_arn: []const u8,

    pub const json_field_names = .{
        .routing_control_arn = "RoutingControlArn",
    };
};

pub const GetRoutingControlStateOutput = struct {
    /// The Amazon Resource Name (ARN) of the response.
    routing_control_arn: []const u8,

    /// The routing control name.
    routing_control_name: ?[]const u8 = null,

    /// The state of the routing control.
    routing_control_state: RoutingControlState,

    pub const json_field_names = .{
        .routing_control_arn = "RoutingControlArn",
        .routing_control_name = "RoutingControlName",
        .routing_control_state = "RoutingControlState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRoutingControlStateInput, options: CallOptions) !GetRoutingControlStateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-cluster", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRoutingControlStateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-cluster", "Route53 Recovery Cluster", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ToggleCustomerAPI.GetRoutingControlState");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRoutingControlStateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetRoutingControlStateOutput, body, allocator);
}
