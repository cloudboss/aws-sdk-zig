const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoutingControl = @import("routing_control.zig").RoutingControl;

pub const UpdateRoutingControlInput = struct {
    /// The Amazon Resource Name (ARN) of the routing control.
    routing_control_arn: []const u8,

    /// The name of the routing control.
    routing_control_name: []const u8,

    pub const json_field_names = .{
        .routing_control_arn = "RoutingControlArn",
        .routing_control_name = "RoutingControlName",
    };
};

pub const UpdateRoutingControlOutput = struct {
    /// The routing control that was updated.
    routing_control: ?RoutingControl = null,

    pub const json_field_names = .{
        .routing_control = "RoutingControl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRoutingControlInput, options: CallOptions) !UpdateRoutingControlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-control-config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRoutingControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-control-config", "Route53 Recovery Control Config", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/routingcontrol";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoutingControlArn\":");
    try aws.json.writeValue(@TypeOf(input.routing_control_arn), input.routing_control_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoutingControlName\":");
    try aws.json.writeValue(@TypeOf(input.routing_control_name), input.routing_control_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRoutingControlOutput {
    const result: UpdateRoutingControlOutput = try aws.json.parseJsonObject(
        UpdateRoutingControlOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
