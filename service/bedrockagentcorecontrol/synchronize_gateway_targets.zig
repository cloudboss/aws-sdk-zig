const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GatewayTarget = @import("gateway_target.zig").GatewayTarget;

pub const SynchronizeGatewayTargetsInput = struct {
    /// The gateway Identifier.
    gateway_identifier: []const u8,

    /// The target ID list.
    target_id_list: []const []const u8,

    pub const json_field_names = .{
        .gateway_identifier = "gatewayIdentifier",
        .target_id_list = "targetIdList",
    };
};

pub const SynchronizeGatewayTargetsOutput = struct {
    /// The gateway targets for synchronization.
    targets: ?[]const GatewayTarget = null,

    pub const json_field_names = .{
        .targets = "targets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SynchronizeGatewayTargetsInput, options: CallOptions) !SynchronizeGatewayTargetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SynchronizeGatewayTargetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/synchronizeTargets");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetIdList\":");
    try aws.json.writeValue(@TypeOf(input.target_id_list), input.target_id_list, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SynchronizeGatewayTargetsOutput {
    const result: SynchronizeGatewayTargetsOutput = try aws.json.parseJsonObject(
        SynchronizeGatewayTargetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
