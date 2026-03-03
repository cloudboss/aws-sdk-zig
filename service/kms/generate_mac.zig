const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MacAlgorithmSpec = @import("mac_algorithm_spec.zig").MacAlgorithmSpec;

pub const GenerateMacInput = struct {
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

    /// The HMAC KMS key to use in the operation. The MAC algorithm computes the
    /// HMAC for the
    /// message and the key as described in [RFC
    /// 2104](https://datatracker.ietf.org/doc/html/rfc2104).
    ///
    /// To identify an HMAC KMS key, use the DescribeKey operation and see the
    /// `KeySpec` field in the response.
    key_id: []const u8,

    /// The MAC algorithm used in the operation.
    ///
    /// The algorithm must be compatible with the HMAC KMS key that you specify. To
    /// find the MAC
    /// algorithms that your HMAC KMS key supports, use the DescribeKey operation
    /// and see the `MacAlgorithms` field in the `DescribeKey` response.
    mac_algorithm: MacAlgorithmSpec,

    /// The message to be hashed. Specify a message of up to 4,096 bytes.
    ///
    /// `GenerateMac` and VerifyMac do not provide special handling
    /// for message digests. If you generate an HMAC for a hash digest of a message,
    /// you must verify
    /// the HMAC of the same hash digest.
    message: []const u8,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .grant_tokens = "GrantTokens",
        .key_id = "KeyId",
        .mac_algorithm = "MacAlgorithm",
        .message = "Message",
    };
};

pub const GenerateMacOutput = struct {
    /// The HMAC KMS key used in the operation.
    key_id: ?[]const u8 = null,

    /// The hash-based message authentication code (HMAC) that was generated for the
    /// specified
    /// message, HMAC KMS key, and MAC algorithm.
    ///
    /// This is the standard, raw HMAC defined in [RFC
    /// 2104](https://datatracker.ietf.org/doc/html/rfc2104).
    mac: ?[]const u8 = null,

    /// The MAC algorithm that was used to generate the HMAC.
    mac_algorithm: ?MacAlgorithmSpec = null,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .mac = "Mac",
        .mac_algorithm = "MacAlgorithm",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateMacInput, options: Options) !GenerateMacOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateMacInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.GenerateMac");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateMacOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GenerateMacOutput, body, allocator);
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
