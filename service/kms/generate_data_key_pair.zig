const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const DataKeyPairSpec = @import("data_key_pair_spec.zig").DataKeyPairSpec;
const RecipientInfo = @import("recipient_info.zig").RecipientInfo;

pub const GenerateDataKeyPairInput = struct {
    /// Checks if your request will succeed. `DryRun` is an optional parameter.
    ///
    /// To learn more about how to use this parameter, see [Testing your
    /// permissions](https://docs.aws.amazon.com/kms/latest/developerguide/testing-permissions.html) in the *Key Management Service Developer Guide*.
    dry_run: ?bool = null,

    /// Specifies the encryption context that will be used when encrypting the
    /// private key in the
    /// data key pair.
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

    /// Specifies the symmetric encryption KMS key that encrypts the private key in
    /// the data key
    /// pair. You cannot specify an asymmetric KMS key or a KMS key in a custom key
    /// store. To get the
    /// type and origin of your KMS key, use the DescribeKey operation.
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

    /// Determines the type of data key pair that is generated.
    ///
    /// The KMS rule that restricts the use of asymmetric RSA and SM2 KMS keys to
    /// encrypt and decrypt or to sign and verify (but not both), the rule that
    /// permits you to use ECC KMS keys only to sign and verify, and the rule that
    /// permits you to use ML-DSA key pairs to sign and verify only are not
    /// effective on data key pairs, which are used outside of KMS. The SM2 key spec
    /// is only available in China Regions.
    key_pair_spec: DataKeyPairSpec,

    /// A signed [attestation
    /// document](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nitro-enclave-how.html#term-attestdoc) from
    /// an Amazon Web Services Nitro enclave or NitroTPM, and the encryption
    /// algorithm to use with the public key in
    /// the attestation document. The only valid encryption algorithm is
    /// `RSAES_OAEP_SHA_256`.
    ///
    /// This parameter only supports attestation documents for Amazon Web Services
    /// Nitro Enclaves or
    /// Amazon Web Services NitroTPM. To call GenerateDataKeyPair generate an
    /// attestation document use either
    /// [Amazon Web Services Nitro Enclaves
    /// SDK](https://docs.aws.amazon.com/enclaves/latest/user/developing-applications.html#sdk) for an Amazon Web Services Nitro Enclaves or [Amazon Web Services NitroTPM tools](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/attestation-get-doc.html) for
    /// Amazon Web Services NitroTPM. Then use the Recipient parameter from any
    /// Amazon Web Services SDK to provide the
    /// attestation document for the attested environment.
    ///
    /// When you use this parameter, instead of returning a plaintext copy of the
    /// private data
    /// key, KMS encrypts the plaintext private data key under the public key in the
    /// attestation
    /// document, and returns the resulting ciphertext in the
    /// `CiphertextForRecipient`
    /// field in the response. This ciphertext can be decrypted only with the
    /// private key in the
    /// attested environment. The `CiphertextBlob` field in the response contains a
    /// copy of
    /// the private data key encrypted under the KMS key specified by the `KeyId`
    /// parameter. The `PrivateKeyPlaintext` field in the response is null or empty.
    ///
    /// For information about the interaction between KMS and Amazon Web Services
    /// Nitro Enclaves or Amazon Web Services NitroTPM, see [Cryptographic
    /// attestation support in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/cryptographic-attestation.html) in the *Key Management Service Developer Guide*.
    recipient: ?RecipientInfo = null,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .encryption_context = "EncryptionContext",
        .grant_tokens = "GrantTokens",
        .key_id = "KeyId",
        .key_pair_spec = "KeyPairSpec",
        .recipient = "Recipient",
    };
};

pub const GenerateDataKeyPairOutput = struct {
    /// The plaintext private data key encrypted with the public key from the
    /// attestation
    /// document. This ciphertext can be decrypted only by using a private key from
    /// the attested
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

    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the KMS key that encrypted the private key.
    key_id: ?[]const u8 = null,

    /// The identifier of the key material used to encrypt the private key.
    key_material_id: ?[]const u8 = null,

    /// The type of data key pair that was generated.
    key_pair_spec: ?DataKeyPairSpec = null,

    /// The encrypted copy of the private key. When you use the HTTP API or the
    /// Amazon Web Services CLI, the value is Base64-encoded. Otherwise, it is not
    /// Base64-encoded.
    private_key_ciphertext_blob: ?[]const u8 = null,

    /// The plaintext copy of the private key. When you use the HTTP API or the
    /// Amazon Web Services CLI, the value is Base64-encoded. Otherwise, it is not
    /// Base64-encoded.
    ///
    /// If the response includes the `CiphertextForRecipient` field, the
    /// `PrivateKeyPlaintext` field is null or empty.
    private_key_plaintext: ?[]const u8 = null,

    /// The public key (in plaintext). When you use the HTTP API or the Amazon Web
    /// Services CLI, the value is Base64-encoded. Otherwise, it is not
    /// Base64-encoded.
    public_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .ciphertext_for_recipient = "CiphertextForRecipient",
        .key_id = "KeyId",
        .key_material_id = "KeyMaterialId",
        .key_pair_spec = "KeyPairSpec",
        .private_key_ciphertext_blob = "PrivateKeyCiphertextBlob",
        .private_key_plaintext = "PrivateKeyPlaintext",
        .public_key = "PublicKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateDataKeyPairInput, options: CallOptions) !GenerateDataKeyPairOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateDataKeyPairInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.GenerateDataKeyPair");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateDataKeyPairOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GenerateDataKeyPairOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        const parsed_error: ?errors.AlreadyExistsException = aws.json.parseJsonObject(errors.AlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterInUseException")) {
        const parsed_error: ?errors.CloudHsmClusterInUseException = aws.json.parseJsonObject(errors.CloudHsmClusterInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterInvalidConfigurationException")) {
        const parsed_error: ?errors.CloudHsmClusterInvalidConfigurationException = aws.json.parseJsonObject(errors.CloudHsmClusterInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterNotActiveException")) {
        const parsed_error: ?errors.CloudHsmClusterNotActiveException = aws.json.parseJsonObject(errors.CloudHsmClusterNotActiveException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_not_active_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterNotFoundException")) {
        const parsed_error: ?errors.CloudHsmClusterNotFoundException = aws.json.parseJsonObject(errors.CloudHsmClusterNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterNotRelatedException")) {
        const parsed_error: ?errors.CloudHsmClusterNotRelatedException = aws.json.parseJsonObject(errors.CloudHsmClusterNotRelatedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_not_related_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreHasCMKsException")) {
        const parsed_error: ?errors.CustomKeyStoreHasCMKsException = aws.json.parseJsonObject(errors.CustomKeyStoreHasCMKsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_key_store_has_cm_ks_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreInvalidStateException")) {
        const parsed_error: ?errors.CustomKeyStoreInvalidStateException = aws.json.parseJsonObject(errors.CustomKeyStoreInvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_key_store_invalid_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreNameInUseException")) {
        const parsed_error: ?errors.CustomKeyStoreNameInUseException = aws.json.parseJsonObject(errors.CustomKeyStoreNameInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_key_store_name_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreNotFoundException")) {
        const parsed_error: ?errors.CustomKeyStoreNotFoundException = aws.json.parseJsonObject(errors.CustomKeyStoreNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_key_store_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DependencyTimeoutException")) {
        const parsed_error: ?errors.DependencyTimeoutException = aws.json.parseJsonObject(errors.DependencyTimeoutException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .dependency_timeout_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DisabledException")) {
        const parsed_error: ?errors.DisabledException = aws.json.parseJsonObject(errors.DisabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .disabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DryRunOperationException")) {
        const parsed_error: ?errors.DryRunOperationException = aws.json.parseJsonObject(errors.DryRunOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .dry_run_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExpiredImportTokenException")) {
        const parsed_error: ?errors.ExpiredImportTokenException = aws.json.parseJsonObject(errors.ExpiredImportTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .expired_import_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncorrectKeyException")) {
        const parsed_error: ?errors.IncorrectKeyException = aws.json.parseJsonObject(errors.IncorrectKeyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incorrect_key_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncorrectKeyMaterialException")) {
        const parsed_error: ?errors.IncorrectKeyMaterialException = aws.json.parseJsonObject(errors.IncorrectKeyMaterialException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incorrect_key_material_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncorrectTrustAnchorException")) {
        const parsed_error: ?errors.IncorrectTrustAnchorException = aws.json.parseJsonObject(errors.IncorrectTrustAnchorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incorrect_trust_anchor_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAliasNameException")) {
        const parsed_error: ?errors.InvalidAliasNameException = aws.json.parseJsonObject(errors.InvalidAliasNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_alias_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidArnException")) {
        const parsed_error: ?errors.InvalidArnException = aws.json.parseJsonObject(errors.InvalidArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCiphertextException")) {
        const parsed_error: ?errors.InvalidCiphertextException = aws.json.parseJsonObject(errors.InvalidCiphertextException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_ciphertext_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGrantIdException")) {
        const parsed_error: ?errors.InvalidGrantIdException = aws.json.parseJsonObject(errors.InvalidGrantIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_grant_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGrantTokenException")) {
        const parsed_error: ?errors.InvalidGrantTokenException = aws.json.parseJsonObject(errors.InvalidGrantTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_grant_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidImportTokenException")) {
        const parsed_error: ?errors.InvalidImportTokenException = aws.json.parseJsonObject(errors.InvalidImportTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_import_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyUsageException")) {
        const parsed_error: ?errors.InvalidKeyUsageException = aws.json.parseJsonObject(errors.InvalidKeyUsageException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_key_usage_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMarkerException")) {
        const parsed_error: ?errors.InvalidMarkerException = aws.json.parseJsonObject(errors.InvalidMarkerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_marker_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KeyUnavailableException")) {
        const parsed_error: ?errors.KeyUnavailableException = aws.json.parseJsonObject(errors.KeyUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .key_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInternalException")) {
        const parsed_error: ?errors.KMSInternalException = aws.json.parseJsonObject(errors.KMSInternalException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_internal_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidMacException")) {
        const parsed_error: ?errors.KMSInvalidMacException = aws.json.parseJsonObject(errors.KMSInvalidMacException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_mac_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidSignatureException")) {
        const parsed_error: ?errors.KMSInvalidSignatureException = aws.json.parseJsonObject(errors.KMSInvalidSignatureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_signature_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        const parsed_error: ?errors.KMSInvalidStateException = aws.json.parseJsonObject(errors.KMSInvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        const parsed_error: ?errors.MalformedPolicyDocumentException = aws.json.parseJsonObject(errors.MalformedPolicyDocumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        const parsed_error: ?errors.NotFoundException = aws.json.parseJsonObject(errors.NotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagException")) {
        const parsed_error: ?errors.TagException = aws.json.parseJsonObject(errors.TagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        const parsed_error: ?errors.UnsupportedOperationException = aws.json.parseJsonObject(errors.UnsupportedOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksKeyAlreadyInUseException")) {
        const parsed_error: ?errors.XksKeyAlreadyInUseException = aws.json.parseJsonObject(errors.XksKeyAlreadyInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_key_already_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksKeyInvalidConfigurationException")) {
        const parsed_error: ?errors.XksKeyInvalidConfigurationException = aws.json.parseJsonObject(errors.XksKeyInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_key_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksKeyNotFoundException")) {
        const parsed_error: ?errors.XksKeyNotFoundException = aws.json.parseJsonObject(errors.XksKeyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_key_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyIncorrectAuthenticationCredentialException")) {
        const parsed_error: ?errors.XksProxyIncorrectAuthenticationCredentialException = aws.json.parseJsonObject(errors.XksProxyIncorrectAuthenticationCredentialException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_incorrect_authentication_credential_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyInvalidConfigurationException")) {
        const parsed_error: ?errors.XksProxyInvalidConfigurationException = aws.json.parseJsonObject(errors.XksProxyInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyInvalidResponseException")) {
        const parsed_error: ?errors.XksProxyInvalidResponseException = aws.json.parseJsonObject(errors.XksProxyInvalidResponseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_invalid_response_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyUriEndpointInUseException")) {
        const parsed_error: ?errors.XksProxyUriEndpointInUseException = aws.json.parseJsonObject(errors.XksProxyUriEndpointInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_uri_endpoint_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyUriInUseException")) {
        const parsed_error: ?errors.XksProxyUriInUseException = aws.json.parseJsonObject(errors.XksProxyUriInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_uri_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyUriUnreachableException")) {
        const parsed_error: ?errors.XksProxyUriUnreachableException = aws.json.parseJsonObject(errors.XksProxyUriUnreachableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_uri_unreachable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyVpcEndpointServiceInUseException")) {
        const parsed_error: ?errors.XksProxyVpcEndpointServiceInUseException = aws.json.parseJsonObject(errors.XksProxyVpcEndpointServiceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_vpc_endpoint_service_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyVpcEndpointServiceInvalidConfigurationException")) {
        const parsed_error: ?errors.XksProxyVpcEndpointServiceInvalidConfigurationException = aws.json.parseJsonObject(errors.XksProxyVpcEndpointServiceInvalidConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_vpc_endpoint_service_invalid_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "XksProxyVpcEndpointServiceNotFoundException")) {
        const parsed_error: ?errors.XksProxyVpcEndpointServiceNotFoundException = aws.json.parseJsonObject(errors.XksProxyVpcEndpointServiceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .xks_proxy_vpc_endpoint_service_not_found_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
