const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportSource = @import("import_source.zig").ImportSource;
const Tags = @import("tags.zig").Tags;
const KeyValueStore = @import("key_value_store.zig").KeyValueStore;
const serde = @import("serde.zig");

pub const CreateKeyValueStoreInput = struct {
    /// The comment of the key value store.
    comment: ?[]const u8 = null,

    /// The S3 bucket that provides the source for the import. The source must be in
    /// a valid JSON format.
    import_source: ?ImportSource = null,

    /// The name of the key value store. The minimum length is 1 character and the
    /// maximum length is 64 characters.
    name: []const u8,

    tags: ?Tags = null,
};

pub const CreateKeyValueStoreOutput = struct {
    /// The `ETag` in the resulting key value store.
    e_tag: ?[]const u8 = null,

    /// The resulting key value store.
    key_value_store: ?KeyValueStore = null,

    /// The location of the resulting key value store.
    location: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKeyValueStoreInput, options: CallOptions) !CreateKeyValueStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKeyValueStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/key-value-store";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateKeyValueStoreRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    if (input.comment) |v| {
        try body_buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Comment>");
    }
    if (input.import_source) |v| {
        try body_buf.appendSlice(allocator, "<ImportSource>");
        try serde.serializeImportSource(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</ImportSource>");
    }
    try body_buf.appendSlice(allocator, "<Name>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "</Name>");
    if (input.tags) |v| {
        try body_buf.appendSlice(allocator, "<Tags>");
        try serde.serializeTags(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Tags>");
    }
    try body_buf.appendSlice(allocator, "</CreateKeyValueStoreRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKeyValueStoreOutput {
    var result: CreateKeyValueStoreOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
