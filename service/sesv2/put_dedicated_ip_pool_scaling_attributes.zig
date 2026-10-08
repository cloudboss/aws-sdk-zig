const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScalingMode = @import("scaling_mode.zig").ScalingMode;

pub const PutDedicatedIpPoolScalingAttributesInput = struct {
    /// The name of the dedicated IP pool.
    pool_name: []const u8,

    /// The scaling mode to apply to the dedicated IP pool.
    ///
    /// Changing the scaling mode from `MANAGED` to `STANDARD` is not supported.
    scaling_mode: ScalingMode,

    pub const json_field_names = .{
        .pool_name = "PoolName",
        .scaling_mode = "ScalingMode",
    };
};

pub const PutDedicatedIpPoolScalingAttributesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDedicatedIpPoolScalingAttributesInput, options: CallOptions) !PutDedicatedIpPoolScalingAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDedicatedIpPoolScalingAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/dedicated-ip-pools/");
    try path_buf.appendSlice(allocator, input.pool_name);
    try path_buf.appendSlice(allocator, "/scaling");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ScalingMode\":");
    try aws.json.writeValue(@TypeOf(input.scaling_mode), input.scaling_mode, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDedicatedIpPoolScalingAttributesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutDedicatedIpPoolScalingAttributesOutput = .{};

    return result;
}
