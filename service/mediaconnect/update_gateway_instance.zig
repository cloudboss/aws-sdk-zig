const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BridgePlacement = @import("bridge_placement.zig").BridgePlacement;

pub const UpdateGatewayInstanceInput = struct {
    /// The state of the instance. `ACTIVE` or `INACTIVE`.
    bridge_placement: ?BridgePlacement = null,

    /// The Amazon Resource Name (ARN) of the gateway instance that you want to
    /// update.
    gateway_instance_arn: []const u8,

    pub const json_field_names = .{
        .bridge_placement = "BridgePlacement",
        .gateway_instance_arn = "GatewayInstanceArn",
    };
};

pub const UpdateGatewayInstanceOutput = struct {
    /// The state of the instance. `ACTIVE` or `INACTIVE`.
    bridge_placement: ?BridgePlacement = null,

    /// The ARN of the instance that was updated.
    gateway_instance_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .bridge_placement = "BridgePlacement",
        .gateway_instance_arn = "GatewayInstanceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGatewayInstanceInput, options: CallOptions) !UpdateGatewayInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGatewayInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/gateway-instances/");
    try path_buf.appendSlice(allocator, input.gateway_instance_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bridge_placement) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BridgePlacement\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGatewayInstanceOutput {
    const result: UpdateGatewayInstanceOutput = try aws.json.parseJsonObject(
        UpdateGatewayInstanceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
