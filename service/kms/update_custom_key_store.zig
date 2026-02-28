const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const XksProxyAuthenticationCredentialType = @import("xks_proxy_authentication_credential_type.zig").XksProxyAuthenticationCredentialType;
const XksProxyConnectivityType = @import("xks_proxy_connectivity_type.zig").XksProxyConnectivityType;

pub const UpdateCustomKeyStoreInput = struct {
    /// Associates the custom key store with a related CloudHSM cluster. This
    /// parameter is valid only
    /// for custom key stores with a `CustomKeyStoreType` of
    /// `AWS_CLOUDHSM`.
    ///
    /// Enter the cluster ID of the cluster that you used to create the custom key
    /// store or a
    /// cluster that shares a backup history and has the same cluster certificate as
    /// the original
    /// cluster. You cannot use this parameter to associate a custom key store with
    /// an unrelated
    /// cluster. In addition, the replacement cluster must [fulfill the
    /// requirements](https://docs.aws.amazon.com/kms/latest/developerguide/create-keystore.html#before-keystore) for
    /// a cluster associated with a custom key store. To view the cluster
    /// certificate of a cluster,
    /// use the
    /// [DescribeClusters](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html) operation.
    ///
    /// To change this value, the CloudHSM key store must be disconnected.
    cloud_hsm_cluster_id: ?[]const u8 = null,

    /// Identifies the custom key store that you want to update. Enter the ID of the
    /// custom key
    /// store. To find the ID of a custom key store, use the DescribeCustomKeyStores
    /// operation.
    custom_key_store_id: []const u8,

    /// Enter the current password of the `kmsuser` crypto user (CU) in the CloudHSM
    /// cluster that is associated with the custom key store. This parameter is
    /// valid only for custom
    /// key stores with a `CustomKeyStoreType` of `AWS_CLOUDHSM`.
    ///
    /// This parameter tells KMS the current password of the `kmsuser` crypto user
    /// (CU). It does not set or change the password of any users in the CloudHSM
    /// cluster.
    ///
    /// To change this value, the CloudHSM key store must be disconnected.
    key_store_password: ?[]const u8 = null,

    /// Changes the friendly name of the custom key store to the value that you
    /// specify. The
    /// custom key store name must be unique in the Amazon Web Services account.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// To change this value, an CloudHSM key store must be disconnected. An
    /// external key store can
    /// be connected or disconnected.
    new_custom_key_store_name: ?[]const u8 = null,

    /// Changes the credentials that KMS uses to sign requests to the external key
    /// store proxy
    /// (XKS proxy). This parameter is valid only for custom key stores with a
    /// `CustomKeyStoreType` of `EXTERNAL_KEY_STORE`.
    ///
    /// You must specify both the `AccessKeyId` and `SecretAccessKey` value
    /// in the authentication credential, even if you are only updating one value.
    ///
    /// This parameter doesn't establish or change your authentication credentials
    /// on the proxy.
    /// It just tells KMS the credential that you established with your external key
    /// store proxy.
    /// For example, if you rotate the credential on your external key store proxy,
    /// you can use this
    /// parameter to update the credential in KMS.
    ///
    /// You can change this value when the external key store is connected or
    /// disconnected.
    xks_proxy_authentication_credential: ?XksProxyAuthenticationCredentialType = null,

    /// Changes the connectivity setting for the external key store. To indicate
    /// that the external
    /// key store proxy uses a Amazon VPC endpoint service to communicate with KMS,
    /// specify
    /// `VPC_ENDPOINT_SERVICE`. Otherwise, specify `PUBLIC_ENDPOINT`.
    ///
    /// If you change the `XksProxyConnectivity` to `VPC_ENDPOINT_SERVICE`,
    /// you must also change the `XksProxyUriEndpoint` and add an
    /// `XksProxyVpcEndpointServiceName` value.
    ///
    /// If you change the `XksProxyConnectivity` to `PUBLIC_ENDPOINT`, you
    /// must also change the `XksProxyUriEndpoint` and specify a null or empty
    /// string for
    /// the `XksProxyVpcEndpointServiceName` value.
    ///
    /// To change this value, the external key store must be disconnected.
    xks_proxy_connectivity: ?XksProxyConnectivityType = null,

    /// Changes the URI endpoint that KMS uses to connect to your external key store
    /// proxy (XKS
    /// proxy). This parameter is valid only for custom key stores with a
    /// `CustomKeyStoreType` of `EXTERNAL_KEY_STORE`.
    ///
    /// For external key stores with an `XksProxyConnectivity` value of
    /// `PUBLIC_ENDPOINT`, the protocol must be HTTPS.
    ///
    /// For external key stores with an `XksProxyConnectivity` value of
    /// `VPC_ENDPOINT_SERVICE`, specify `https://` followed by the private DNS
    /// name associated with the VPC endpoint service. Each external key store must
    /// use a different
    /// private DNS name.
    ///
    /// The combined `XksProxyUriEndpoint` and `XksProxyUriPath` values must
    /// be unique in the Amazon Web Services account and Region.
    ///
    /// To change this value, the external key store must be disconnected.
    xks_proxy_uri_endpoint: ?[]const u8 = null,

    /// Changes the base path to the proxy APIs for this external key store. To find
    /// this value,
    /// see the documentation for your external key manager and external key store
    /// proxy (XKS proxy).
    /// This parameter is valid only for custom key stores with a
    /// `CustomKeyStoreType` of
    /// `EXTERNAL_KEY_STORE`.
    ///
    /// The value must start with `/` and must end with `/kms/xks/v1`, where
    /// `v1` represents the version of the KMS external key store proxy API. You can
    /// include an optional prefix between the required elements such as
    /// `/*example*/kms/xks/v1`.
    ///
    /// The combined `XksProxyUriEndpoint` and `XksProxyUriPath` values must
    /// be unique in the Amazon Web Services account and Region.
    ///
    /// You can change this value when the external key store is connected or
    /// disconnected.
    xks_proxy_uri_path: ?[]const u8 = null,

    /// Changes the name that KMS uses to identify the Amazon VPC endpoint service
    /// for your external
    /// key store proxy (XKS proxy). This parameter is valid when the
    /// `CustomKeyStoreType`
    /// is `EXTERNAL_KEY_STORE` and the `XksProxyConnectivity` is
    /// `VPC_ENDPOINT_SERVICE`.
    ///
    /// To change this value, the external key store must be disconnected.
    xks_proxy_vpc_endpoint_service_name: ?[]const u8 = null,

    /// Changes the Amazon Web Services account ID that KMS uses to identify the
    /// Amazon VPC endpoint service for
    /// your external key store proxy (XKS proxy). This parameter is optional. If
    /// not specified, the current
    /// Amazon Web Services account ID for the VPC endpoint service will not be
    /// updated.
    ///
    /// To change this value, the external key store must be disconnected.
    xks_proxy_vpc_endpoint_service_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_hsm_cluster_id = "CloudHsmClusterId",
        .custom_key_store_id = "CustomKeyStoreId",
        .key_store_password = "KeyStorePassword",
        .new_custom_key_store_name = "NewCustomKeyStoreName",
        .xks_proxy_authentication_credential = "XksProxyAuthenticationCredential",
        .xks_proxy_connectivity = "XksProxyConnectivity",
        .xks_proxy_uri_endpoint = "XksProxyUriEndpoint",
        .xks_proxy_uri_path = "XksProxyUriPath",
        .xks_proxy_vpc_endpoint_service_name = "XksProxyVpcEndpointServiceName",
        .xks_proxy_vpc_endpoint_service_owner = "XksProxyVpcEndpointServiceOwner",
    };
};

pub const UpdateCustomKeyStoreOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCustomKeyStoreInput, options: Options) !UpdateCustomKeyStoreOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateCustomKeyStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kms", "KMS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "TrentService.UpdateCustomKeyStore");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateCustomKeyStoreOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
