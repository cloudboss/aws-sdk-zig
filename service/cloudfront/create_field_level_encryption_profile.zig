const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FieldLevelEncryptionProfileConfig = @import("field_level_encryption_profile_config.zig").FieldLevelEncryptionProfileConfig;
const FieldLevelEncryptionProfile = @import("field_level_encryption_profile.zig").FieldLevelEncryptionProfile;
const serde = @import("serde.zig");

pub const CreateFieldLevelEncryptionProfileInput = struct {
    /// The request to create a field-level encryption profile.
    field_level_encryption_profile_config: FieldLevelEncryptionProfileConfig,
};

pub const CreateFieldLevelEncryptionProfileOutput = struct {
    /// The current version of the field level encryption profile. For example:
    /// `E2QWRUHAPOMQZL`.
    e_tag: ?[]const u8 = null,

    /// Returned when you create a new field-level encryption profile.
    field_level_encryption_profile: ?FieldLevelEncryptionProfile = null,

    /// The fully qualified URI of the new profile resource just created.
    location: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFieldLevelEncryptionProfileInput, options: CallOptions) !CreateFieldLevelEncryptionProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFieldLevelEncryptionProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/field-level-encryption-profile";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<FieldLevelEncryptionProfileConfig xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try serde.serializeFieldLevelEncryptionProfileConfig(allocator, &body_buf, input.field_level_encryption_profile_config);
    try body_buf.appendSlice(allocator, "</FieldLevelEncryptionProfileConfig>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFieldLevelEncryptionProfileOutput {
    var result: CreateFieldLevelEncryptionProfileOutput = .{};
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
