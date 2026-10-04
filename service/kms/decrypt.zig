const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DryRunModifierType = @import("dry_run_modifier_type.zig").DryRunModifierType;
const EncryptionAlgorithmSpec = @import("encryption_algorithm_spec.zig").EncryptionAlgorithmSpec;
const RecipientInfo = @import("recipient_info.zig").RecipientInfo;

pub const DecryptInput = struct {
    /// Ciphertext to be decrypted. The blob includes metadata.
    ///
    /// This parameter is required in all cases except when `DryRun` is `true` and
    /// `DryRunModifiers` is set to `IGNORE_CIPHERTEXT`.
    ciphertext_blob: ?[]const u8 = null,

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

    /// Specifies the encryption algorithm that will be used to decrypt the
    /// ciphertext. Specify
    /// the same algorithm that was used to encrypt the data. If you specify a
    /// different algorithm,
    /// the `Decrypt` operation fails.
    ///
    /// This parameter is required only when the ciphertext was encrypted under an
    /// asymmetric KMS
    /// key. The default value, `SYMMETRIC_DEFAULT`, represents the only supported
    /// algorithm that is valid for symmetric encryption KMS keys.
    encryption_algorithm: ?EncryptionAlgorithmSpec = null,

    /// Specifies the encryption context to use when decrypting the data.
    /// An encryption context is valid only for [cryptographic
    /// operations](https://docs.aws.amazon.com/kms/latest/developerguide/kms-cryptography.html#cryptographic-operations) with a symmetric encryption KMS key. The standard asymmetric encryption algorithms and HMAC algorithms that KMS uses do not support an encryption context.
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

    /// Specifies the KMS key that KMS uses to decrypt the ciphertext.
    ///
    /// Enter a key ID of the KMS key that was used to encrypt the ciphertext. If
    /// you identify a
    /// different KMS key, the `Decrypt` operation throws an
    /// `IncorrectKeyException`.
    ///
    /// This parameter is required only when the ciphertext was encrypted under an
    /// asymmetric KMS
    /// key or when `DryRun` is `true` and `DryRunModifiers` is set to
    /// `IGNORE_CIPHERTEXT`. If you used a symmetric encryption KMS key, KMS can get
    /// the KMS key from metadata that
    /// it adds to the symmetric ciphertext blob. However, it is always recommended
    /// as a best
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
    key_id: ?[]const u8 = null,

    /// A signed [attestation
    /// document](https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave-concepts.html#term-attestdoc) from an Amazon Web Services Nitro enclave or NitroTPM, and the encryption algorithm to
    /// use with the public key in the attestation document. The only valid
    /// encryption algorithm is
    /// `RSAES_OAEP_SHA_256`.
    ///
    /// This parameter supports the [Amazon Web Services Nitro Enclaves
    /// SDK](https://docs.aws.amazon.com/enclaves/latest/user/developing-applications.html#sdk) or any Amazon Web Services SDK for
    /// Amazon Web Services Nitro Enclaves. It supports any Amazon Web Services SDK
    /// for Amazon Web Services NitroTPM.
    ///
    /// When you use this parameter, instead of returning the plaintext data, KMS
    /// encrypts the
    /// plaintext data with the public key in the attestation document, and returns
    /// the resulting
    /// ciphertext in the `CiphertextForRecipient` field in the response. This
    /// ciphertext
    /// can be decrypted only with the private key in the attested environment. The
    /// `Plaintext` field in the response is null or empty.
    ///
    /// For information about the interaction between KMS and Amazon Web Services
    /// Nitro Enclaves or Amazon Web Services NitroTPM, see [Cryptographic
    /// attestation support in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/cryptographic-attestation.html) in the *Key Management Service Developer Guide*.
    recipient: ?RecipientInfo = null,

    pub const json_field_names = .{
        .ciphertext_blob = "CiphertextBlob",
        .dry_run = "DryRun",
        .dry_run_modifiers = "DryRunModifiers",
        .encryption_algorithm = "EncryptionAlgorithm",
        .encryption_context = "EncryptionContext",
        .grant_tokens = "GrantTokens",
        .key_id = "KeyId",
        .recipient = "Recipient",
    };
};

pub const DecryptOutput = struct {
    /// The plaintext data encrypted with the public key from the attestation
    /// document. This
    /// ciphertext can be decrypted only by using a private key from the attested
    /// environment.
    ///
    /// This field is included in the response only when the `Recipient` parameter
    /// in
    /// the request includes a valid attestation document from an Amazon Web
    /// Services Nitro enclave or NitroTPM.
    /// For information about the interaction between KMS and Amazon Web Services
    /// Nitro Enclaves or Amazon Web Services NitroTPM, see [Cryptographic
    /// attestation support in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/cryptographic-attestation.html) in the *Key Management Service Developer Guide*.
    ciphertext_for_recipient: ?[]const u8 = null,

    /// The encryption algorithm that was used to decrypt the ciphertext.
    encryption_algorithm: ?EncryptionAlgorithmSpec = null,

    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the KMS key that was used to decrypt the ciphertext.
    key_id: ?[]const u8 = null,

    /// The identifier of the key material used to decrypt the ciphertext. This
    /// field is present
    /// only when the operation uses a symmetric encryption KMS key. This field is
    /// omitted if the
    /// request includes the `Recipient` parameter.
    key_material_id: ?[]const u8 = null,

    /// Decrypted plaintext data. When you use the HTTP API or the Amazon Web
    /// Services CLI, the value is Base64-encoded. Otherwise, it is not
    /// Base64-encoded.
    ///
    /// If the response includes the `CiphertextForRecipient` field, the
    /// `Plaintext` field is null or empty.
    plaintext: ?[]const u8 = null,

    pub const json_field_names = .{
        .ciphertext_for_recipient = "CiphertextForRecipient",
        .encryption_algorithm = "EncryptionAlgorithm",
        .key_id = "KeyId",
        .key_material_id = "KeyMaterialId",
        .plaintext = "Plaintext",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DecryptInput, options: CallOptions) !DecryptOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DecryptInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.Decrypt");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DecryptOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DecryptOutput, body, allocator);
}
