const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomerMasterKeySpec = @import("customer_master_key_spec.zig").CustomerMasterKeySpec;
const EncryptionAlgorithmSpec = @import("encryption_algorithm_spec.zig").EncryptionAlgorithmSpec;
const KeyAgreementAlgorithmSpec = @import("key_agreement_algorithm_spec.zig").KeyAgreementAlgorithmSpec;
const KeySpec = @import("key_spec.zig").KeySpec;
const KeyUsageType = @import("key_usage_type.zig").KeyUsageType;
const SigningAlgorithmSpec = @import("signing_algorithm_spec.zig").SigningAlgorithmSpec;

pub const GetPublicKeyInput = struct {
    /// A list of grant tokens.
    ///
    /// Use a grant token when your permission to call this operation comes from a
    /// new grant that has not yet achieved *eventual consistency*. For more
    /// information, see [Grant
    /// token](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#grant_token) and [Using a grant token](https://docs.aws.amazon.com/kms/latest/developerguide/using-grant-token.html) in the
    /// *Key Management Service Developer Guide*.
    grant_tokens: ?[]const []const u8 = null,

    /// Identifies the asymmetric KMS key that includes the public key.
    ///
    /// To specify a KMS key, use its key ID, key ARN, alias name, or alias ARN.
    /// When using an alias name, prefix it with `"alias/"`. To specify a KMS key in
    /// a different Amazon Web Services account, you must use the key ARN or alias
    /// ARN.
    ///
    /// For example:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Alias name: `alias/ExampleAlias`
    ///
    /// * Alias ARN: `arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey. To
    /// get the alias name and alias ARN, use ListAliases.
    key_id: []const u8,

    pub const json_field_names = .{
        .grant_tokens = "GrantTokens",
        .key_id = "KeyId",
    };
};

pub const GetPublicKeyOutput = struct {
    /// Instead, use the `KeySpec` field in the `GetPublicKey`
    /// response.
    ///
    /// The `KeySpec` and `CustomerMasterKeySpec` fields have the same
    /// value. We recommend that you use the `KeySpec` field in your code. However,
    /// to
    /// avoid breaking changes, KMS supports both fields.
    customer_master_key_spec: ?CustomerMasterKeySpec = null,

    /// The encryption algorithms that KMS supports for this key.
    ///
    /// This information is critical. If a public key encrypts data outside of KMS
    /// by using an
    /// unsupported encryption algorithm, the ciphertext cannot be decrypted.
    ///
    /// This field appears in the response only when the `KeyUsage` of the public
    /// key
    /// is `ENCRYPT_DECRYPT`.
    encryption_algorithms: ?[]const EncryptionAlgorithmSpec = null,

    /// The key agreement algorithm used to derive a shared secret. This field is
    /// present only
    /// when the KMS key has a `KeyUsage` value of `KEY_AGREEMENT`.
    key_agreement_algorithms: ?[]const KeyAgreementAlgorithmSpec = null,

    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the asymmetric KMS key from which the public key was
    /// downloaded.
    key_id: ?[]const u8 = null,

    /// The type of the of the public key that was downloaded.
    key_spec: ?KeySpec = null,

    /// The permitted use of the public key. Valid values for asymmetric key pairs
    /// are
    /// `ENCRYPT_DECRYPT`, `SIGN_VERIFY`, and `KEY_AGREEMENT`.
    ///
    /// This information is critical. For example, if a public key with
    /// `SIGN_VERIFY`
    /// key usage encrypts data outside of KMS, the ciphertext cannot be decrypted.
    key_usage: ?KeyUsageType = null,

    /// The exported public key.
    ///
    /// The value is a DER-encoded X.509 public key, also known as
    /// `SubjectPublicKeyInfo` (SPKI), as defined in [RFC
    /// 5280](https://tools.ietf.org/html/rfc5280). When you use the HTTP API or the
    /// Amazon Web Services CLI, the value is Base64-encoded. Otherwise, it is not
    /// Base64-encoded.
    public_key: ?[]const u8 = null,

    /// The signing algorithms that KMS supports for this key.
    ///
    /// This field appears in the response only when the `KeyUsage` of the public
    /// key
    /// is `SIGN_VERIFY`.
    signing_algorithms: ?[]const SigningAlgorithmSpec = null,

    pub const json_field_names = .{
        .customer_master_key_spec = "CustomerMasterKeySpec",
        .encryption_algorithms = "EncryptionAlgorithms",
        .key_agreement_algorithms = "KeyAgreementAlgorithms",
        .key_id = "KeyId",
        .key_spec = "KeySpec",
        .key_usage = "KeyUsage",
        .public_key = "PublicKey",
        .signing_algorithms = "SigningAlgorithms",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPublicKeyInput, options: CallOptions) !GetPublicKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPublicKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kms", "KMS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.GetPublicKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPublicKeyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPublicKeyOutput, body, allocator);
}
