const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoutingControl = @import("routing_control.zig").RoutingControl;

pub const CreateRoutingControlInput = struct {
    /// A unique, case-sensitive string of up to 64 ASCII characters. To make an
    /// idempotent API request with an action, specify a client token in the
    /// request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the cluster that includes the routing
    /// control.
    cluster_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the control panel that includes the
    /// routing control.
    control_panel_arn: ?[]const u8 = null,

    /// The name of the routing control.
    routing_control_name: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .cluster_arn = "ClusterArn",
        .control_panel_arn = "ControlPanelArn",
        .routing_control_name = "RoutingControlName",
    };
};

pub const CreateRoutingControlOutput = struct {
    /// The routing control that is created.
    routing_control: ?RoutingControl = null,

    pub const json_field_names = .{
        .routing_control = "RoutingControl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRoutingControlInput, options: CallOptions) !CreateRoutingControlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRoutingControlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-control-config", "Route53 Recovery Control Config", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/routingcontrol";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClusterArn\":");
    try aws.json.writeValue(@TypeOf(input.cluster_arn), input.cluster_arn, allocator, &body_buf);
    has_prev = true;
    if (input.control_panel_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ControlPanelArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoutingControlName\":");
    try aws.json.writeValue(@TypeOf(input.routing_control_name), input.routing_control_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRoutingControlOutput {
    var result: CreateRoutingControlOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRoutingControlOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
