const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddBridgeOutputRequest = @import("add_bridge_output_request.zig").AddBridgeOutputRequest;
const BridgeOutput = @import("bridge_output.zig").BridgeOutput;

pub const AddBridgeOutputsInput = struct {
    /// The Amazon Resource Name (ARN) of the bridge that you want to update.
    bridge_arn: []const u8,

    /// The outputs that you want to add to this bridge.
    outputs: []const AddBridgeOutputRequest,

    pub const json_field_names = .{
        .bridge_arn = "BridgeArn",
        .outputs = "Outputs",
    };
};

pub const AddBridgeOutputsOutput = struct {
    /// The ARN of the bridge that you added outputs to.
    bridge_arn: ?[]const u8 = null,

    /// The outputs that you added to this bridge.
    outputs: ?[]const BridgeOutput = null,

    pub const json_field_names = .{
        .bridge_arn = "BridgeArn",
        .outputs = "Outputs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddBridgeOutputsInput, options: CallOptions) !AddBridgeOutputsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddBridgeOutputsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/bridges/");
    try path_buf.appendSlice(allocator, input.bridge_arn);
    try path_buf.appendSlice(allocator, "/outputs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Outputs\":");
    try aws.json.writeValue(@TypeOf(input.outputs), input.outputs, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddBridgeOutputsOutput {
    const result: AddBridgeOutputsOutput = try aws.json.parseJsonObject(
        AddBridgeOutputsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
