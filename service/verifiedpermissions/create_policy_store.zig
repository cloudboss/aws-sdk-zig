const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletionProtection = @import("deletion_protection.zig").DeletionProtection;
const EncryptionSettings = @import("encryption_settings.zig").EncryptionSettings;
const ValidationSettings = @import("validation_settings.zig").ValidationSettings;

pub const CreatePolicyStoreInput = struct {
    /// Specifies a unique, case-sensitive ID that you provide to ensure the
    /// idempotency of the request. This lets you safely retry the request without
    /// accidentally performing the same operation a second time. Passing the same
    /// value to a later call to an operation requires that you also pass the same
    /// value for all other parameters. We recommend that you use a [UUID type of
    /// value.](https://wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// If you don't provide this value, then Amazon Web Services generates a random
    /// one for you.
    ///
    /// If you retry the operation with the same `ClientToken`, but with different
    /// parameters, the retry fails with an `ConflictException` error.
    ///
    /// Verified Permissions recognizes a `ClientToken` for eight hours. After eight
    /// hours, the next request with the same parameters performs the operation
    /// again regardless of the value of `ClientToken`.
    client_token: ?[]const u8 = null,

    /// Specifies whether the policy store can be deleted. If enabled, the policy
    /// store can't be deleted.
    ///
    /// The default state is `DISABLED`.
    deletion_protection: ?DeletionProtection = null,

    /// Descriptive text that you can provide to help with identification of the
    /// current policy store.
    description: ?[]const u8 = null,

    /// Specifies the encryption settings used to encrypt the policy store and their
    /// child resources. Allows for the ability to use a customer owned KMS key for
    /// encryption of data.
    ///
    /// This is an optional field to be used when providing a customer-managed KMS
    /// key for encryption.
    encryption_settings: ?EncryptionSettings = null,

    /// The list of key-value pairs to associate with the policy store.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the validation setting for this policy store.
    ///
    /// Currently, the only valid and required value is `Mode`.
    ///
    /// We recommend that you turn on `STRICT` mode only after you define a schema.
    /// If a schema doesn't exist, then `STRICT` mode causes any policy to fail
    /// validation, and Verified Permissions rejects the policy. You can turn off
    /// validation by using the
    /// [UpdatePolicyStore](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_UpdatePolicyStore). Then, when you have a schema defined, use [UpdatePolicyStore](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_UpdatePolicyStore) again to turn validation back on.
    validation_settings: ValidationSettings,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .deletion_protection = "deletionProtection",
        .description = "description",
        .encryption_settings = "encryptionSettings",
        .tags = "tags",
        .validation_settings = "validationSettings",
    };
};

pub const CreatePolicyStoreOutput = struct {
    /// The Amazon Resource Name (ARN) of the new policy store.
    arn: []const u8,

    /// The date and time the policy store was originally created.
    created_date: i64,

    /// The date and time the policy store was last updated.
    last_updated_date: i64,

    /// The unique ID of the new policy store.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_date = "createdDate",
        .last_updated_date = "lastUpdatedDate",
        .policy_store_id = "policyStoreId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePolicyStoreInput, options: CallOptions) !CreatePolicyStoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "verifiedpermissions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePolicyStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("verifiedpermissions", "VerifiedPermissions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VerifiedPermissions.CreatePolicyStore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePolicyStoreOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreatePolicyStoreOutput, body, allocator);
}
