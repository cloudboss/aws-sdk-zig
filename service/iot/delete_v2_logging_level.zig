const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogTargetType = @import("log_target_type.zig").LogTargetType;

pub const DeleteV2LoggingLevelInput = struct {
    /// The name of the resource for which you are configuring logging.
    target_name: []const u8,

    /// The type of resource for which you are configuring logging. Must be
    /// `THING_Group`.
    target_type: LogTargetType,

    pub const json_field_names = .{
        .target_name = "targetName",
        .target_type = "targetType",
    };
};

pub const DeleteV2LoggingLevelOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteV2LoggingLevelInput, options: CallOptions) !DeleteV2LoggingLevelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteV2LoggingLevelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2LoggingLevel";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "targetName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.target_name);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "targetType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.target_type.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteV2LoggingLevelOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteV2LoggingLevelOutput = .{};

    return result;
}
