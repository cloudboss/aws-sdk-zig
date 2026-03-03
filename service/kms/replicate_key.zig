const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const KeyMetadata = @import("key_metadata.zig").KeyMetadata;

pub const ReplicateKeyInput = struct {
    /// Skips ("bypasses") the key policy lockout safety check. The default value is
    /// false.
    ///
    /// Setting this value to true increases the risk that the KMS key becomes
    /// unmanageable. Do
    /// not set this value to true indiscriminately.
    ///
    /// For more information, see [Default key
    /// policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#prevent-unmanageable-key) in the *Key Management Service Developer Guide*.
    ///
    /// Use this parameter only when you intend to prevent the principal that is
    /// making the
    /// request from making a subsequent
    /// [PutKeyPolicy](https://docs.aws.amazon.com/kms/latest/APIReference/API_PutKeyPolicy.html)
    /// request on the KMS key.
    bypass_policy_lockout_safety_check: ?bool = null,

    /// A description of the KMS key. The default value is an empty string (no
    /// description).
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// The description is not a shared property of multi-Region keys. You can
    /// specify the same
    /// description or a different description for each key in a set of related
    /// multi-Region keys.
    /// KMS does not synchronize this property.
    description: ?[]const u8 = null,

    /// Identifies the multi-Region primary key that is being replicated. To
    /// determine whether a
    /// KMS key is a multi-Region primary key, use the DescribeKey operation to
    /// check the value of the `MultiRegionKeyType` property.
    ///
    /// Specify the key ID or key ARN of a multi-Region primary key.
    ///
    /// For example:
    ///
    /// * Key ID: `mrk-1234abcd12ab34cd56ef1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/mrk-1234abcd12ab34cd56ef1234567890ab`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey.
    key_id: []const u8,

    /// The key policy to attach to the KMS key. This parameter is optional. If you
    /// do not provide
    /// a key policy, KMS attaches the [default key
    /// policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html) to the KMS key.
    ///
    /// The key policy is not a shared property of multi-Region keys. You can
    /// specify the same key
    /// policy or a different key policy for each key in a set of related
    /// multi-Region keys. KMS
    /// does not synchronize this property.
    ///
    /// If you provide a key policy, it must meet the following criteria:
    ///
    /// * The key policy must allow the calling principal to make a
    /// subsequent `PutKeyPolicy` request on the KMS key. This reduces the risk that
    /// the KMS key becomes unmanageable. For more information, see [Default key
    /// policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#prevent-unmanageable-key) in the *Key Management Service Developer Guide*. (To omit
    /// this condition, set `BypassPolicyLockoutSafetyCheck` to true.)
    ///
    /// * Each statement in the key policy must contain one or more principals. The
    ///   principals
    /// in the key policy must exist and be visible to KMS. When you create a new
    /// Amazon Web Services
    /// principal, you might need to enforce a delay before including the new
    /// principal in a key
    /// policy because the new principal might not be immediately visible to KMS.
    /// For more
    /// information, see [Changes that I make are not always immediately
    /// visible](https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_general.html#troubleshoot_general_eventual-consistency) in the *Amazon Web Services
    /// Identity and Access Management User Guide*.
    ///
    /// A key policy document can include only the following characters:
    ///
    /// * Printable ASCII characters from the space character (`\u0020`) through the
    ///   end of the ASCII character range.
    ///
    /// * Printable characters in the Basic Latin and Latin-1 Supplement character
    ///   set (through `\u00FF`).
    ///
    /// * The tab (`\u0009`), line feed (`\u000A`), and carriage return (`\u000D`)
    ///   special characters
    ///
    /// For information about key policies, see [Key policies in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html) in the *Key Management Service Developer Guide*.
    /// For help writing and formatting a JSON policy document, see the [IAM JSON
    /// Policy
    /// Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies.html) in the *
    /// Identity and Access Management User Guide*
    /// .
    policy: ?[]const u8 = null,

    /// The Region ID of the Amazon Web Services Region for this replica key.
    ///
    /// Enter the Region ID, such as `us-east-1` or `ap-southeast-2`. For a
    /// list of Amazon Web Services Regions in which KMS is supported, see [KMS
    /// service
    /// endpoints](https://docs.aws.amazon.com/general/latest/gr/kms.html#kms_region) in the
    /// *Amazon Web Services General Reference*.
    ///
    /// The replica must be in a different Amazon Web Services Region than its
    /// primary key and other replicas of
    /// that primary key, but in the same Amazon Web Services partition. KMS must be
    /// available in the replica
    /// Region. If the Region is not enabled by default, the Amazon Web Services
    /// account must be enabled in the
    /// Region. For information about Amazon Web Services partitions, see [Amazon
    /// Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference*. For information about enabling and
    /// disabling Regions, see [Enabling a
    /// Region](https://docs.aws.amazon.com/general/latest/gr/rande-manage.html#rande-manage-enable) and [Disabling a Region](https://docs.aws.amazon.com/general/latest/gr/rande-manage.html#rande-manage-disable) in the
    /// *Amazon Web Services General Reference*.
    replica_region: []const u8,

    /// Assigns one or more tags to the replica key. Use this parameter to tag the
    /// KMS key when it
    /// is created. To tag an existing KMS key, use the TagResource
    /// operation.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// Tagging or untagging a KMS key can allow or deny permission to the KMS key.
    /// For details, see [ABAC for
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/abac.html) in the
    /// *Key Management Service Developer Guide*.
    ///
    /// To use this parameter, you must have
    /// [kms:TagResource](https://docs.aws.amazon.com/kms/latest/developerguide/kms-api-permissions-reference.html) permission in an IAM policy.
    ///
    /// Tags are not a shared property of multi-Region keys. You can specify the
    /// same tags or
    /// different tags for each key in a set of related multi-Region keys. KMS does
    /// not synchronize
    /// this property.
    ///
    /// Each tag consists of a tag key and a tag value. Both the tag key and the tag
    /// value are
    /// required, but the tag value can be an empty (null) string. You cannot have
    /// more than one tag
    /// on a KMS key with the same tag key. If you specify an existing tag key with
    /// a different tag
    /// value, KMS replaces the current tag value with the specified one.
    ///
    /// When you add tags to an Amazon Web Services resource, Amazon Web Services
    /// generates a cost allocation
    /// report with usage and costs aggregated by tags. Tags can also be used to
    /// control access to a KMS key. For details,
    /// see [Tags in
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/tagging-keys.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .bypass_policy_lockout_safety_check = "BypassPolicyLockoutSafetyCheck",
        .description = "Description",
        .key_id = "KeyId",
        .policy = "Policy",
        .replica_region = "ReplicaRegion",
        .tags = "Tags",
    };
};

pub const ReplicateKeyOutput = struct {
    /// Displays details about the new replica key, including its Amazon Resource
    /// Name ([key
    /// ARN](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)) and
    /// [Key states of KMS
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html).
    /// It also includes the ARN and Amazon Web Services Region of its primary key
    /// and other
    /// replica keys.
    replica_key_metadata: ?KeyMetadata = null,

    /// The key policy of the new replica key. The value is a key policy document in
    /// JSON
    /// format.
    replica_policy: ?[]const u8 = null,

    /// The tags on the new replica key. The value is a list of tag key and tag
    /// value
    /// pairs.
    replica_tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .replica_key_metadata = "ReplicaKeyMetadata",
        .replica_policy = "ReplicaPolicy",
        .replica_tags = "ReplicaTags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReplicateKeyInput, options: Options) !ReplicateKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ReplicateKeyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.ReplicateKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReplicateKeyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ReplicateKeyOutput, body, allocator);
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
