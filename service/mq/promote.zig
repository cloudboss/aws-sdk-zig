const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PromoteMode = @import("promote_mode.zig").PromoteMode;

pub const PromoteInput = struct {
    /// The unique ID that Amazon MQ generates for the broker.
    broker_id: []const u8,

    /// The Promote mode requested. Note: Valid values for the parameter are
    /// SWITCHOVER, FAILOVER.
    mode: PromoteMode,

    pub const json_field_names = .{
        .broker_id = "BrokerId",
        .mode = "Mode",
    };
};

pub const PromoteOutput = struct {
    /// The unique ID that Amazon MQ generates for the broker.
    broker_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .broker_id = "BrokerId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PromoteInput, options: CallOptions) !PromoteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mq", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PromoteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/brokers/");
    try path_buf.appendSlice(allocator, input.broker_id);
    try path_buf.appendSlice(allocator, "/promote");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Mode\":");
    try aws.json.writeValue(@TypeOf(input.mode), input.mode, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PromoteOutput {
    const result: PromoteOutput = try aws.json.parseJsonObject(
        PromoteOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
