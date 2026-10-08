const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionType = @import("encryption_type.zig").EncryptionType;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;

pub const PutEncryptionConfigInput = struct {
    /// An Amazon Web Services KMS key in one of the following formats:
    ///
    /// * **Alias** - The name of the key. For example,
    /// `alias/MyKey`.
    ///
    /// * **Key ID** - The KMS key ID of the key. For example,
    /// `ae4aa6d49-a4d8-9df9-a475-4ff6d7898456`. Amazon Web Services X-Ray does not
    /// support asymmetric KMS keys.
    ///
    /// * **ARN** - The full Amazon Resource Name of the key ID or alias.
    /// For example,
    /// `arn:aws:kms:us-east-2:123456789012:key/ae4aa6d49-a4d8-9df9-a475-4ff6d7898456`.
    /// Use this format to specify a key in a different account.
    ///
    /// Omit this key if you set `Type` to `NONE`.
    key_id: ?[]const u8 = null,

    /// The type of encryption. Set to `KMS` to use your own key for encryption. Set
    /// to `NONE` for default encryption.
    type: EncryptionType,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .type = "Type",
    };
};

pub const PutEncryptionConfigOutput = struct {
    /// The new encryption configuration.
    encryption_config: ?EncryptionConfig = null,

    pub const json_field_names = .{
        .encryption_config = "EncryptionConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutEncryptionConfigInput, options: CallOptions) !PutEncryptionConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "xray", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutEncryptionConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/PutEncryptionConfig";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Type\":");
    try aws.json.writeValue(@TypeOf(input.type), input.type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutEncryptionConfigOutput {
    const result: PutEncryptionConfigOutput = try aws.json.parseJsonObject(
        PutEncryptionConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
