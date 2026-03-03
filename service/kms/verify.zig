const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MessageType = @import("message_type.zig").MessageType;
const SigningAlgorithmSpec = @import("signing_algorithm_spec.zig").SigningAlgorithmSpec;

pub const VerifyInput = struct {
    /// Checks if your request will succeed. `DryRun` is an optional parameter.
    ///
    /// To learn more about how to use this parameter, see [Testing your
    /// permissions](https://docs.aws.amazon.com/kms/latest/developerguide/testing-permissions.html) in the *Key Management Service Developer Guide*.
    dry_run: ?bool = null,

    /// A list of grant tokens.
    ///
    /// Use a grant token when your permission to call this operation comes from a
    /// new grant that has not yet achieved *eventual consistency*. For more
    /// information, see [Grant
    /// token](https://docs.aws.amazon.com/kms/latest/developerguide/grants.html#grant_token) and [Using a grant token](https://docs.aws.amazon.com/kms/latest/developerguide/using-grant-token.html) in the
    /// *Key Management Service Developer Guide*.
    grant_tokens: ?[]const []const u8 = null,

    /// Identifies the asymmetric KMS key that will be used to verify the signature.
    /// This must be
    /// the same KMS key that was used to generate the signature. If you specify a
    /// different KMS key,
    /// the signature verification fails.
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

    /// Specifies the message that was signed. You can submit a raw message of up to
    /// 4096 bytes,
    /// or a hash digest of the message. If you submit a digest, use the
    /// `MessageType`
    /// parameter with a value of `DIGEST`.
    ///
    /// If the message specified here is different from the message that was signed,
    /// the signature
    /// verification fails. A message and its hash digest are considered to be the
    /// same
    /// message.
    message: []const u8,

    /// Tells KMS whether the value of the `Message` parameter should be hashed as
    /// part of the signing algorithm. Use `RAW` for unhashed messages; use
    /// `DIGEST` for message digests, which are already hashed; use
    /// `EXTERNAL_MU` for 64-byte representative μ used in ML-DSA signing as defined
    /// in NIST FIPS 204 Section 6.2.
    ///
    /// When the value of `MessageType` is `RAW`, KMS uses the standard
    /// signing algorithm, which begins with a hash function. When the value is
    /// `DIGEST`,
    /// KMS skips the hashing step in the signing algorithm. When the value is
    /// `EXTERNAL_MU` KMS skips the concatenated hashing of the public key hash and
    /// the
    /// message done in the ML-DSA signing algorithm.
    ///
    /// Use the `DIGEST` or `EXTERNAL_MU` value only when the value of the
    /// `Message` parameter is a message digest. If you use the `DIGEST`
    /// value with an unhashed message, the security of the signing operation can be
    /// compromised.
    ///
    /// When using ECC_NIST_EDWARDS25519 KMS keys:
    ///
    /// * ED25519_SHA_512 signing algorithm requires KMS `MessageType:RAW`
    ///
    /// * ED25519_PH_SHA_512 signing algorithm requires KMS `MessageType:DIGEST`
    ///
    /// When the value of `MessageType` is `DIGEST`, the length of the
    /// `Message` value must match the length of hashed messages for the specified
    /// signing algorithm.
    ///
    /// When the value of `MessageType` is `EXTERNAL_MU` the length of the
    /// `Message` value must be 64 bytes.
    ///
    /// You can submit a message digest and omit the `MessageType` or specify
    /// `RAW` so the digest is hashed again while signing. However, if the signed
    /// message
    /// is hashed once while signing, but twice while verifying, verification fails,
    /// even when the
    /// message hasn't changed.
    ///
    /// The hashing algorithm that `Verify` uses is based on the
    /// `SigningAlgorithm` value.
    ///
    /// * Signing algorithms that end in SHA_256 use the SHA_256 hashing algorithm.
    ///
    /// * Signing algorithms that end in SHA_384 use the SHA_384 hashing algorithm.
    ///
    /// * Signing algorithms that end in SHA_512 use the SHA_512 hashing algorithm.
    ///
    /// * Signing algorithms that end in SHAKE_256 use the SHAKE_256 hashing
    ///   algorithm.
    ///
    /// * SM2DSA uses the SM3 hashing algorithm. For details, see [Offline
    /// verification with SM2 key
    /// pairs](https://docs.aws.amazon.com/kms/latest/developerguide/offline-operations.html#key-spec-sm-offline-verification).
    message_type: ?MessageType = null,

    /// The signature that the `Sign` operation generated.
    signature: []const u8,

    /// The signing algorithm that was used to sign the message. If you submit a
    /// different
    /// algorithm, the signature verification fails.
    signing_algorithm: SigningAlgorithmSpec,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .grant_tokens = "GrantTokens",
        .key_id = "KeyId",
        .message = "Message",
        .message_type = "MessageType",
        .signature = "Signature",
        .signing_algorithm = "SigningAlgorithm",
    };
};

pub const VerifyOutput = struct {
    /// The Amazon Resource Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) of the asymmetric KMS key that was used to verify the signature.
    key_id: ?[]const u8 = null,

    /// A Boolean value that indicates whether the signature was verified. A value
    /// of
    /// `True` indicates that the `Signature` was produced by signing the
    /// `Message` with the specified `KeyID` and
    /// `SigningAlgorithm.` If the signature is not verified, the `Verify`
    /// operation fails with a `KMSInvalidSignatureException` exception.
    signature_valid: ?bool = null,

    /// The signing algorithm that was used to verify the signature.
    signing_algorithm: ?SigningAlgorithmSpec = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .signature_valid = "SignatureValid",
        .signing_algorithm = "SigningAlgorithm",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyInput, options: Options) !VerifyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kms");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kms", "KMS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.Verify");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(VerifyOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterInUseException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterInvalidConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_invalid_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterNotActiveException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_not_active_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmClusterNotRelatedException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_cluster_not_related_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreHasCMKsException")) {
        return .{ .arena = arena, .kind = .{ .custom_key_store_has_cm_ks_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .custom_key_store_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreNameInUseException")) {
        return .{ .arena = arena, .kind = .{ .custom_key_store_name_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomKeyStoreNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .custom_key_store_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .dependency_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DisabledException")) {
        return .{ .arena = arena, .kind = .{ .disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DryRunOperationException")) {
        return .{ .arena = arena, .kind = .{ .dry_run_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredImportTokenException")) {
        return .{ .arena = arena, .kind = .{ .expired_import_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectKeyException")) {
        return .{ .arena = arena, .kind = .{ .incorrect_key_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectKeyMaterialException")) {
        return .{ .arena = arena, .kind = .{ .incorrect_key_material_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectTrustAnchorException")) {
        return .{ .arena = arena, .kind = .{ .incorrect_trust_anchor_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAliasNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_alias_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCiphertextException")) {
        return .{ .arena = arena, .kind = .{ .invalid_ciphertext_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGrantIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_grant_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGrantTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_grant_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidImportTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_import_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKeyUsageException")) {
        return .{ .arena = arena, .kind = .{ .invalid_key_usage_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMarkerException")) {
        return .{ .arena = arena, .kind = .{ .invalid_marker_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeyUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .key_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInternalException")) {
        return .{ .arena = arena, .kind = .{ .kms_internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidMacException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_mac_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidSignatureException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_signature_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagException")) {
        return .{ .arena = arena, .kind = .{ .tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksKeyAlreadyInUseException")) {
        return .{ .arena = arena, .kind = .{ .xks_key_already_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksKeyInvalidConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .xks_key_invalid_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksKeyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .xks_key_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksProxyIncorrectAuthenticationCredentialException")) {
        return .{ .arena = arena, .kind = .{ .xks_proxy_incorrect_authentication_credential_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksProxyInvalidConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .xks_proxy_invalid_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksProxyInvalidResponseException")) {
        return .{ .arena = arena, .kind = .{ .xks_proxy_invalid_response_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksProxyUriEndpointInUseException")) {
        return .{ .arena = arena, .kind = .{ .xks_proxy_uri_endpoint_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksProxyUriInUseException")) {
        return .{ .arena = arena, .kind = .{ .xks_proxy_uri_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksProxyUriUnreachableException")) {
        return .{ .arena = arena, .kind = .{ .xks_proxy_uri_unreachable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksProxyVpcEndpointServiceInUseException")) {
        return .{ .arena = arena, .kind = .{ .xks_proxy_vpc_endpoint_service_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksProxyVpcEndpointServiceInvalidConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .xks_proxy_vpc_endpoint_service_invalid_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "XksProxyVpcEndpointServiceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .xks_proxy_vpc_endpoint_service_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
