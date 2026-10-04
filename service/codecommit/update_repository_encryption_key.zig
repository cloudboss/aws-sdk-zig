const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateRepositoryEncryptionKeyInput = struct {
    /// The ID of the encryption key. You can view the ID of an encryption key in
    /// the KMS console, or use the KMS APIs to
    /// programmatically retrieve a key ID. For more information about acceptable
    /// values for keyID, see
    /// [KeyId](https://docs.aws.amazon.com/kms/latest/APIReference/API_Decrypt.html#KMS-Decrypt-request-KeyId) in the Decrypt API description in
    /// the *Key Management Service API Reference*.
    kms_key_id: []const u8,

    /// The name of the repository for which you want to update the KMS encryption
    /// key used to encrypt and decrypt the repository.
    repository_name: []const u8,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .repository_name = "repositoryName",
    };
};

pub const UpdateRepositoryEncryptionKeyOutput = struct {
    /// The ID of the encryption key.
    kms_key_id: ?[]const u8 = null,

    /// The ID of the encryption key formerly used to encrypt and decrypt the
    /// repository.
    original_kms_key_id: ?[]const u8 = null,

    /// The ID of the repository.
    repository_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .original_kms_key_id = "originalKmsKeyId",
        .repository_id = "repositoryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRepositoryEncryptionKeyInput, options: CallOptions) !UpdateRepositoryEncryptionKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRepositoryEncryptionKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.UpdateRepositoryEncryptionKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRepositoryEncryptionKeyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateRepositoryEncryptionKeyOutput, body, allocator);
}
