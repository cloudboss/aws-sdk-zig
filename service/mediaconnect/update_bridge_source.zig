const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateBridgeFlowSourceRequest = @import("update_bridge_flow_source_request.zig").UpdateBridgeFlowSourceRequest;
const UpdateBridgeNetworkSourceRequest = @import("update_bridge_network_source_request.zig").UpdateBridgeNetworkSourceRequest;
const BridgeSource = @import("bridge_source.zig").BridgeSource;

pub const UpdateBridgeSourceInput = struct {
    /// The Amazon Resource Name (ARN) of the bridge that you want to update.
    bridge_arn: []const u8,

    /// The name of the flow that you want to update.
    flow_source: ?UpdateBridgeFlowSourceRequest = null,

    /// The network for the bridge source.
    network_source: ?UpdateBridgeNetworkSourceRequest = null,

    /// The name of the source that you want to update.
    source_name: []const u8,

    pub const json_field_names = .{
        .bridge_arn = "BridgeArn",
        .flow_source = "FlowSource",
        .network_source = "NetworkSource",
        .source_name = "SourceName",
    };
};

pub const UpdateBridgeSourceOutput = struct {
    /// The ARN of the updated bridge source.
    bridge_arn: ?[]const u8 = null,

    /// The updated bridge source.
    source: ?BridgeSource = null,

    pub const json_field_names = .{
        .bridge_arn = "BridgeArn",
        .source = "Source",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBridgeSourceInput, options: CallOptions) !UpdateBridgeSourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBridgeSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/bridges/");
    try path_buf.appendSlice(allocator, input.bridge_arn);
    try path_buf.appendSlice(allocator, "/sources/");
    try path_buf.appendSlice(allocator, input.source_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.flow_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FlowSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.network_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NetworkSource\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBridgeSourceOutput {
    const result: UpdateBridgeSourceOutput = try aws.json.parseJsonObject(
        UpdateBridgeSourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
