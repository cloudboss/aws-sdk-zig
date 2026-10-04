const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyGroupConfig = @import("key_group_config.zig").KeyGroupConfig;
const KeyGroup = @import("key_group.zig").KeyGroup;
const serde = @import("serde.zig");

pub const UpdateKeyGroupInput = struct {
    /// The identifier of the key group that you are updating.
    id: []const u8,

    /// The version of the key group that you are updating. The version is the key
    /// group's `ETag` value.
    if_match: ?[]const u8 = null,

    /// The key group configuration.
    key_group_config: KeyGroupConfig,
};

pub const UpdateKeyGroupOutput = struct {
    /// The identifier for this version of the key group.
    e_tag: ?[]const u8 = null,

    /// The key group that was just updated.
    key_group: ?KeyGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateKeyGroupInput, options: CallOptions) !UpdateKeyGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateKeyGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/key-group/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<KeyGroupConfig xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try serde.serializeKeyGroupConfig(allocator, &body_buf, input.key_group_config);
    try body_buf.appendSlice(allocator, "</KeyGroupConfig>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    if (input.if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateKeyGroupOutput {
    var result: UpdateKeyGroupOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
