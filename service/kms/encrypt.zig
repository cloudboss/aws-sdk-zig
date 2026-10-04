const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionAlgorithmSpec = @import("encryption_algorithm_spec.zig").EncryptionAlgorithmSpec;

pub const EncryptInput = struct {
    /// Checks if your request will succeed. `DryRun` is an optional parameter.
    ///
    /// To learn more about how to use this parameter, see [Testing your
    /// permissions](https://docs.aws.amazon.com/kms/latest/developerguide/testing-permissions.html) in the *Key Management Service Developer Guide*.
    dry_run: ?bool = null,

    /// Specifies the encryption algorithm that KMS will use to encrypt the
    /// plaintext message.
    /// The algorithm must be compatible with the KMS key that you specify.
    ///
    /// This parameter is required only for asymmetric KMS keys. The default value,
    /// `SYMMETRIC_DEFAULT`, is the algorithm used for symmetric encryption KMS
    /// keys. If
    /// you are using an asymmetric KMS key, we recommend RSAES_OAEP_SHA_256.
    ///
    /// The SM2PKE algorithm is only available in China Regions.
    encryption_algorithm: ?EncryptionAlgorithmSpec = null,

    /// Specifies the encryption context that will be used to encrypt the data.
    /// An encryption context is valid only for [cryptographic
    /// operations](https://docs.aws.amazon.com/kms/latest/developerguide/kms-cryptography.html#cryptographic-operations) with a symmetric encryption KMS key. The standard asymmetric encryption algorithms and HMAC algorithms that KMS uses do not support an encryption context.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// An *encryption context* is a collection of non-secret key-value pairs that
    /// represent additional authenticated data.
    /// When you use an encryption context to encrypt data, you must specify the
    /// same (an exact case-sensitive match) encryption context to decrypt the data.
    /// An encryption context is supported
    /// only on operations with symmetric encryption KMS keys. On operations with
    /// symmetric encryption KMS keys, an encryption context is optional, but it is
    /// strongly recommended.
    ///
    /// For more information, see
    /// [Encryption
    /// context](https://docs.aws.amazon.com/kms/latest/developerguide/encrypt_context.html) in the *Key Management Service Developer Guide*.
    encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// A list of grant tokens.
    ///
    /// Use a grant token when your permission to call this operation comes from a
    /// new grant that has not yet achieved *eventual consistency*. For more
    /// information, see [Grant
    /// token](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#grant_token) and [Using a grant token](https://docs.aws.amazon.com/kms/latest/developerguide/using-grant-token.html) in the
    /// *Key Management Service Developer Guide*.
    grant_tokens: ?[]const []const u8 = null,

    /// Identifies the KMS key to use in the encryption operation. The KMS key must
    /// have a
    /// `KeyUsage` of `ENCRYPT_DECRYPT`. To find the `KeyUsage` of
    /// a KMS key, use the DescribeKey operation.
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

    /// Data to be encrypted.
    plaintext: []const u8,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .encryption_algorithm = "EncryptionAlgorithm",
        .encryption_context = "EncryptionContext",
        .grant_tokens = "GrantTokens",
        .key_id = "KeyId",
        .plaintext = "Plaintext",
    };
};

pub const EncryptOutput = struct {
    /// The encrypted plaintext. When you use the HTTP API or the Amazon Web
    /// Services CLI, the value is Base64-encoded. Otherwise, it is not
    /// Base64-encoded.
    ciphertext_blob: ?[]const u8 = null,

    /// The encryption algorithm that was used to encrypt the plaintext.
    encryption_algorithm: ?EncryptionAlgorithmSpec = null,

    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the KMS key that was used to encrypt the plaintext.
    key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ciphertext_blob = "CiphertextBlob",
        .encryption_algorithm = "EncryptionAlgorithm",
        .key_id = "KeyId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EncryptInput, options: CallOptions) !EncryptOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EncryptInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.Encrypt");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EncryptOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(EncryptOutput, body, allocator);
}
