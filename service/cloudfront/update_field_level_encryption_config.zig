const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FieldLevelEncryptionConfig = @import("field_level_encryption_config.zig").FieldLevelEncryptionConfig;
const FieldLevelEncryption = @import("field_level_encryption.zig").FieldLevelEncryption;
const serde = @import("serde.zig");

pub const UpdateFieldLevelEncryptionConfigInput = struct {
    /// Request to update a field-level encryption configuration.
    field_level_encryption_config: FieldLevelEncryptionConfig,

    /// The ID of the configuration you want to update.
    id: []const u8,

    /// The value of the `ETag` header that you received when retrieving the
    /// configuration identity to update. For example: `E2QWRUHAPOMQZL`.
    if_match: ?[]const u8 = null,
};

pub const UpdateFieldLevelEncryptionConfigOutput = struct {
    /// The value of the `ETag` header that you received when updating the
    /// configuration. For example: `E2QWRUHAPOMQZL`.
    e_tag: ?[]const u8 = null,

    /// Return the results of updating the configuration.
    field_level_encryption: ?FieldLevelEncryption = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFieldLevelEncryptionConfigInput, options: CallOptions) !UpdateFieldLevelEncryptionConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFieldLevelEncryptionConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/field-level-encryption/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/config");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<FieldLevelEncryptionConfig xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try serde.serializeFieldLevelEncryptionConfig(allocator, &body_buf, input.field_level_encryption_config);
    try body_buf.appendSlice(allocator, "</FieldLevelEncryptionConfig>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFieldLevelEncryptionConfigOutput {
    var result: UpdateFieldLevelEncryptionConfigOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
