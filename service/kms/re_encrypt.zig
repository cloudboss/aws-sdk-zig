const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionAlgorithmSpec = @import("encryption_algorithm_spec.zig").EncryptionAlgorithmSpec;
const DryRunModifierType = @import("dry_run_modifier_type.zig").DryRunModifierType;

pub const ReEncryptInput = struct {
    /// Ciphertext of the data to reencrypt.
    ///
    /// This parameter is required in all cases except when `DryRun` is `true` and
    /// `DryRunModifiers` is set to `IGNORE_CIPHERTEXT`.
    ciphertext_blob: ?[]const u8 = null,

    /// Specifies the encryption algorithm that KMS will use to reecrypt the data
    /// after it has
    /// decrypted it. The default value, `SYMMETRIC_DEFAULT`, represents the
    /// encryption
    /// algorithm used for symmetric encryption KMS keys.
    ///
    /// This parameter is required only when the destination KMS key is an
    /// asymmetric KMS
    /// key.
    destination_encryption_algorithm: ?EncryptionAlgorithmSpec = null,

    /// Specifies that encryption context to use when the reencrypting the data.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// A destination encryption context is valid only when the destination KMS key
    /// is a symmetric
    /// encryption KMS key. The standard ciphertext format for asymmetric KMS keys
    /// does not include
    /// fields for metadata.
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
    destination_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// A unique identifier for the KMS key that is used to reencrypt the data.
    /// Specify a
    /// symmetric encryption KMS key or an asymmetric KMS key with a `KeyUsage`
    /// value of
    /// `ENCRYPT_DECRYPT`. To find the `KeyUsage` value of a KMS key, use the
    /// DescribeKey operation.
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
    destination_key_id: []const u8,

    /// Checks if your request will succeed. `DryRun` is an optional parameter.
    ///
    /// To learn more about how to use this parameter, see [Testing your
    /// permissions](https://docs.aws.amazon.com/kms/latest/developerguide/testing-permissions.html) in the *Key Management Service Developer Guide*.
    dry_run: ?bool = null,

    /// Specifies the modifiers to apply to the dry run operation. `DryRunModifiers`
    /// is an optional parameter that only applies when `DryRun` is
    /// set to `true`.
    ///
    /// When set to `IGNORE_CIPHERTEXT`, KMS performs only authorization validation
    /// without ciphertext validation. This allows you to test permissions
    /// without requiring a valid ciphertext blob.
    ///
    /// To learn more about how to use this parameter, see [Testing your
    /// permissions](https://docs.aws.amazon.com/kms/latest/developerguide/testing-permissions.html) in the *Key Management Service Developer Guide*.
    dry_run_modifiers: ?[]const DryRunModifierType = null,

    /// A list of grant tokens.
    ///
    /// Use a grant token when your permission to call this operation comes from a
    /// new grant that has not yet achieved *eventual consistency*. For more
    /// information, see [Grant
    /// token](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#grant_token) and [Using a grant token](https://docs.aws.amazon.com/kms/latest/developerguide/using-grant-token.html) in the
    /// *Key Management Service Developer Guide*.
    grant_tokens: ?[]const []const u8 = null,

    /// Specifies the encryption algorithm that KMS will use to decrypt the
    /// ciphertext before it
    /// is reencrypted. The default value, `SYMMETRIC_DEFAULT`, represents the
    /// algorithm
    /// used for symmetric encryption KMS keys.
    ///
    /// Specify the same algorithm that was used to encrypt the ciphertext. If you
    /// specify a
    /// different algorithm, the decrypt attempt fails.
    ///
    /// This parameter is required only when the ciphertext was encrypted under an
    /// asymmetric KMS
    /// key.
    source_encryption_algorithm: ?EncryptionAlgorithmSpec = null,

    /// Specifies the encryption context to use to decrypt the ciphertext. Enter the
    /// same
    /// encryption context that was used to encrypt the ciphertext.
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
    source_encryption_context: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the KMS key that KMS will use to decrypt the ciphertext before it
    /// is
    /// re-encrypted.
    ///
    /// Enter a key ID of the KMS key that was used to encrypt the ciphertext. If
    /// you identify a
    /// different KMS key, the `ReEncrypt` operation throws an
    /// `IncorrectKeyException`.
    ///
    /// This parameter is required only when the ciphertext was encrypted under an
    /// asymmetric KMS
    /// key or when `DryRun` is `true` and `DryRunModifiers` is set to
    /// `IGNORE_CIPHERTEXT`. If you used a symmetric encryption KMS key, KMS can get
    /// the KMS key
    /// from metadata that it adds to the symmetric ciphertext blob. However, it is
    /// always recommended as a best
    /// practice. This practice ensures that you use the KMS key that you intend.
    ///
    /// To specify a KMS key, use its key ID, key ARN, alias name, or alias ARN.
    /// When using an alias name, prefix it with `"alias/"`. To specify a KMS key in
    /// a different Amazon Web Services account, you should use the key ARN or alias
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
    source_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ciphertext_blob = "CiphertextBlob",
        .destination_encryption_algorithm = "DestinationEncryptionAlgorithm",
        .destination_encryption_context = "DestinationEncryptionContext",
        .destination_key_id = "DestinationKeyId",
        .dry_run = "DryRun",
        .dry_run_modifiers = "DryRunModifiers",
        .grant_tokens = "GrantTokens",
        .source_encryption_algorithm = "SourceEncryptionAlgorithm",
        .source_encryption_context = "SourceEncryptionContext",
        .source_key_id = "SourceKeyId",
    };
};

pub const ReEncryptOutput = struct {
    /// The reencrypted data. When you use the HTTP API or the Amazon Web Services
    /// CLI, the value is Base64-encoded. Otherwise, it is not Base64-encoded.
    ciphertext_blob: ?[]const u8 = null,

    /// The encryption algorithm that was used to reencrypt the data.
    destination_encryption_algorithm: ?EncryptionAlgorithmSpec = null,

    /// The identifier of the key material used to reencrypt the data. This field is
    /// present only
    /// when data is reencrypted using a symmetric encryption KMS key.
    destination_key_material_id: ?[]const u8 = null,

    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the KMS key that was used to reencrypt the data.
    key_id: ?[]const u8 = null,

    /// The encryption algorithm that was used to decrypt the ciphertext before it
    /// was
    /// reencrypted.
    source_encryption_algorithm: ?EncryptionAlgorithmSpec = null,

    /// Unique identifier of the KMS key used to originally encrypt the data.
    source_key_id: ?[]const u8 = null,

    /// The identifier of the key material used to originally encrypt the data. This
    /// field is
    /// present only when the original encryption used a symmetric encryption KMS
    /// key.
    source_key_material_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ciphertext_blob = "CiphertextBlob",
        .destination_encryption_algorithm = "DestinationEncryptionAlgorithm",
        .destination_key_material_id = "DestinationKeyMaterialId",
        .key_id = "KeyId",
        .source_encryption_algorithm = "SourceEncryptionAlgorithm",
        .source_key_id = "SourceKeyId",
        .source_key_material_id = "SourceKeyMaterialId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReEncryptInput, options: CallOptions) !ReEncryptOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ReEncryptInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.ReEncrypt");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReEncryptOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ReEncryptOutput, body, allocator);
}
