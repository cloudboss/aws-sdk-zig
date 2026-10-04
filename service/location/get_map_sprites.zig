const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetMapSpritesInput = struct {
    /// The name of the sprite ﬁle. Use the following ﬁle names for the sprite
    /// sheet:
    ///
    /// * `sprites.png`
    /// * `sprites@2x.png` for high pixel density displays
    ///
    /// For the JSON document containing image offsets. Use the following ﬁle names:
    ///
    /// * `sprites.json`
    /// * `sprites@2x.json` for high pixel density displays
    file_name: []const u8,

    /// The optional [API
    /// key](https://docs.aws.amazon.com/location/previous/developerguide/using-apikeys.html) to authorize the request.
    key: ?[]const u8 = null,

    /// The map resource associated with the sprite ﬁle.
    map_name: []const u8,

    pub const json_field_names = .{
        .file_name = "FileName",
        .key = "Key",
        .map_name = "MapName",
    };
};

pub const GetMapSpritesOutput = struct {
    /// Contains the body of the sprite sheet or JSON offset ﬁle.
    blob: ?[]const u8 = null,

    /// The HTTP Cache-Control directive for the value.
    cache_control: ?[]const u8 = null,

    /// The content type of the sprite sheet and offsets. For example, the sprite
    /// sheet content type is `image/png`, and the sprite offset JSON document is
    /// `application/json`.
    content_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .blob = "Blob",
        .cache_control = "CacheControl",
        .content_type = "ContentType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMapSpritesInput, options: CallOptions) !GetMapSpritesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMapSpritesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/maps/v0/maps/");
    try path_buf.appendSlice(allocator, input.map_name);
    try path_buf.appendSlice(allocator, "/sprites/");
    try path_buf.appendSlice(allocator, input.file_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMapSpritesOutput {
    var result: GetMapSpritesOutput = .{};
    errdefer {
        if (result.cache_control) |value| allocator.free(value);
        if (result.content_type) |value| allocator.free(value);
        if (result.blob) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.blob = try allocator.dupe(u8, body);
    }
    _ = status;
    if (headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }

    return result;
}
