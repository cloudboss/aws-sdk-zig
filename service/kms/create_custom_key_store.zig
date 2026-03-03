const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CustomKeyStoreType = @import("custom_key_store_type.zig").CustomKeyStoreType;
const XksProxyAuthenticationCredentialType = @import("xks_proxy_authentication_credential_type.zig").XksProxyAuthenticationCredentialType;
const XksProxyConnectivityType = @import("xks_proxy_connectivity_type.zig").XksProxyConnectivityType;

pub const CreateCustomKeyStoreInput = struct {
    /// Identifies the CloudHSM cluster for an CloudHSM key store. This parameter is
    /// required for custom
    /// key stores with `CustomKeyStoreType` of `AWS_CLOUDHSM`.
    ///
    /// Enter the cluster ID of any active CloudHSM cluster that is not already
    /// associated with a
    /// custom key store. To find the cluster ID, use the
    /// [DescribeClusters](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html) operation.
    cloud_hsm_cluster_id: ?[]const u8 = null,

    /// Specifies a friendly name for the custom key store. The name must be unique
    /// in your
    /// Amazon Web Services account and Region. This parameter is required for all
    /// custom key stores.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    custom_key_store_name: []const u8,

    /// Specifies the type of custom key store. The default value is
    /// `AWS_CLOUDHSM`.
    ///
    /// For a custom key store backed by an CloudHSM cluster, omit the parameter or
    /// enter
    /// `AWS_CLOUDHSM`. For a custom key store backed by an external key manager
    /// outside
    /// of Amazon Web Services, enter `EXTERNAL_KEY_STORE`. You cannot change this
    /// property after the key
    /// store is created.
    custom_key_store_type: ?CustomKeyStoreType = null,

    /// Specifies the `kmsuser` password for an CloudHSM key store. This parameter
    /// is
    /// required for custom key stores with a `CustomKeyStoreType` of
    /// `AWS_CLOUDHSM`.
    ///
    /// Enter the password of the [
    /// `kmsuser` crypto user
    /// (CU)
    /// account](https://docs.aws.amazon.com/kms/latest/developerguide/keystore-cloudhsm.html#concept-kmsuser) in the specified CloudHSM cluster. KMS logs into the cluster as this
    /// user to manage key material on your behalf.
    ///
    /// The password must be a string of 7 to 32 characters. Its value is case
    /// sensitive.
    ///
    /// This parameter tells KMS the `kmsuser` account password; it does not change
    /// the password in the CloudHSM cluster.
    key_store_password: ?[]const u8 = null,

    /// Specifies the certificate for an CloudHSM key store. This parameter is
    /// required for custom
    /// key stores with a `CustomKeyStoreType` of `AWS_CLOUDHSM`.
    ///
    /// Enter the content of the trust anchor certificate for the CloudHSM cluster.
    /// This is the
    /// content of the `customerCA.crt` file that you created when you [initialized
    /// the
    /// cluster](https://docs.aws.amazon.com/cloudhsm/latest/userguide/initialize-cluster.html).
    trust_anchor_certificate: ?[]const u8 = null,

    /// Specifies an authentication credential for the external key store proxy (XKS
    /// proxy). This
    /// parameter is required for all custom key stores with a `CustomKeyStoreType`
    /// of
    /// `EXTERNAL_KEY_STORE`.
    ///
    /// The `XksProxyAuthenticationCredential` has two required elements:
    /// `RawSecretAccessKey`, a secret key, and `AccessKeyId`, a unique
    /// identifier for the `RawSecretAccessKey`. For character requirements, see
    /// [XksProxyAuthenticationCredentialType](API_XksProxyAuthenticationCredentialType.html).
    ///
    /// KMS uses this authentication credential to sign requests to the external key
    /// store proxy
    /// on your behalf. This credential is unrelated to Identity and Access
    /// Management (IAM) and Amazon Web Services credentials.
    ///
    /// This parameter doesn't set or change the authentication credentials on the
    /// XKS proxy. It
    /// just tells KMS the credential that you established on your external key
    /// store proxy. If you
    /// rotate your proxy authentication credential, use the UpdateCustomKeyStore
    /// operation to provide the new credential to KMS.
    xks_proxy_authentication_credential: ?XksProxyAuthenticationCredentialType = null,

    /// Indicates how KMS communicates with the external key store proxy. This
    /// parameter is
    /// required for custom key stores with a `CustomKeyStoreType` of
    /// `EXTERNAL_KEY_STORE`.
    ///
    /// If the external key store proxy uses a public endpoint, specify
    /// `PUBLIC_ENDPOINT`. If the external key store proxy uses a Amazon VPC
    /// endpoint service for communication with KMS, specify `VPC_ENDPOINT_SERVICE`.
    /// For
    /// help making this choice, see [Choosing a connectivity
    /// option](https://docs.aws.amazon.com/kms/latest/developerguide/choose-xks-connectivity.html) in
    /// the *Key Management Service Developer Guide*.
    ///
    /// An Amazon VPC endpoint service keeps your communication with KMS in a
    /// private address space
    /// entirely within Amazon Web Services, but it requires more configuration,
    /// including establishing a Amazon VPC with multiple subnets, a VPC endpoint
    /// service, a network load balancer, and a
    /// verified private DNS name. A public endpoint is simpler to set up, but it
    /// might be slower and
    /// might not fulfill your security requirements. You might consider testing
    /// with a public
    /// endpoint, and then establishing a VPC endpoint service for production tasks.
    /// Note that this
    /// choice does not determine the location of the external key store proxy. Even
    /// if you choose a
    /// VPC endpoint service, the proxy can be hosted within the VPC or outside of
    /// Amazon Web Services such as in
    /// your corporate data center.
    xks_proxy_connectivity: ?XksProxyConnectivityType = null,

    /// Specifies the endpoint that KMS uses to send requests to the external key
    /// store proxy
    /// (XKS proxy). This parameter is required for custom key stores with a
    /// `CustomKeyStoreType` of `EXTERNAL_KEY_STORE`.
    ///
    /// The protocol must be HTTPS. KMS communicates on port 443. Do not specify the
    /// port in the
    /// `XksProxyUriEndpoint` value.
    ///
    /// For external key stores with `XksProxyConnectivity` value of
    /// `VPC_ENDPOINT_SERVICE`, specify `https://` followed by the private DNS
    /// name of the VPC endpoint service.
    ///
    /// For external key stores with `PUBLIC_ENDPOINT` connectivity, this endpoint
    /// must
    /// be reachable before you create the custom key store. KMS connects to the
    /// external key store
    /// proxy while creating the custom key store. For external key stores with
    /// `VPC_ENDPOINT_SERVICE` connectivity, KMS connects when you call the
    /// ConnectCustomKeyStore operation.
    ///
    /// The value of this parameter must begin with `https://`. The remainder can
    /// contain upper and lower case letters (A-Z and a-z), numbers (0-9), dots
    /// (`.`), and
    /// hyphens (`-`). Additional slashes (`/` and `\`) are not
    /// permitted.
    ///
    /// **Uniqueness requirements: **
    ///
    /// * The combined `XksProxyUriEndpoint` and `XksProxyUriPath` values
    /// must be unique in the Amazon Web Services account and Region.
    ///
    /// * An external key store with `PUBLIC_ENDPOINT` connectivity cannot use the
    /// same `XksProxyUriEndpoint` value as an external key store with
    /// `VPC_ENDPOINT_SERVICE` connectivity in this Amazon Web Services Region.
    ///
    /// * Each external key store with `VPC_ENDPOINT_SERVICE` connectivity must have
    /// its own private DNS name. The `XksProxyUriEndpoint` value for external key
    /// stores with `VPC_ENDPOINT_SERVICE` connectivity (private DNS name) must be
    /// unique in the Amazon Web Services account and Region.
    xks_proxy_uri_endpoint: ?[]const u8 = null,

    /// Specifies the base path to the proxy APIs for this external key store. To
    /// find this value,
    /// see the documentation for your external key store proxy. This parameter is
    /// required for all
    /// custom key stores with a `CustomKeyStoreType` of
    /// `EXTERNAL_KEY_STORE`.
    ///
    /// The value must start with `/` and must end with `/kms/xks/v1` where
    /// `v1` represents the version of the KMS external key store proxy API. This
    /// path
    /// can include an optional prefix between the required elements such as
    /// `/*prefix*/kms/xks/v1`.
    ///
    /// **Uniqueness requirements: **
    ///
    /// * The combined `XksProxyUriEndpoint` and `XksProxyUriPath` values
    /// must be unique in the Amazon Web Services account and Region.
    xks_proxy_uri_path: ?[]const u8 = null,

    /// Specifies the name of the Amazon VPC endpoint service for interface
    /// endpoints that is used to
    /// communicate with your external key store proxy (XKS proxy). This parameter
    /// is required when
    /// the value of `CustomKeyStoreType` is `EXTERNAL_KEY_STORE` and the value
    /// of `XksProxyConnectivity` is `VPC_ENDPOINT_SERVICE`.
    ///
    /// The Amazon VPC endpoint service must [fulfill all
    /// requirements](https://docs.aws.amazon.com/kms/latest/developerguide/create-xks-keystore.html#xks-requirements) for use with an external key store.
    ///
    /// **Uniqueness requirements:**
    ///
    /// * External key stores with `VPC_ENDPOINT_SERVICE` connectivity can share an
    /// Amazon VPC, but each external key store must have its own VPC endpoint
    /// service and private DNS
    /// name.
    xks_proxy_vpc_endpoint_service_name: ?[]const u8 = null,

    /// Specifies the Amazon Web Services account ID that owns the Amazon VPC
    /// service endpoint for the interface that
    /// is used to communicate with your external key store proxy (XKS proxy). This
    /// parameter is
    /// optional. If not provided, the Amazon Web Services account ID calling the
    /// action will be used.
    xks_proxy_vpc_endpoint_service_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_hsm_cluster_id = "CloudHsmClusterId",
        .custom_key_store_name = "CustomKeyStoreName",
        .custom_key_store_type = "CustomKeyStoreType",
        .key_store_password = "KeyStorePassword",
        .trust_anchor_certificate = "TrustAnchorCertificate",
        .xks_proxy_authentication_credential = "XksProxyAuthenticationCredential",
        .xks_proxy_connectivity = "XksProxyConnectivity",
        .xks_proxy_uri_endpoint = "XksProxyUriEndpoint",
        .xks_proxy_uri_path = "XksProxyUriPath",
        .xks_proxy_vpc_endpoint_service_name = "XksProxyVpcEndpointServiceName",
        .xks_proxy_vpc_endpoint_service_owner = "XksProxyVpcEndpointServiceOwner",
    };
};

pub const CreateCustomKeyStoreOutput = struct {
    /// A unique identifier for the new custom key store.
    custom_key_store_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_key_store_id = "CustomKeyStoreId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomKeyStoreInput, options: CallOptions) !CreateCustomKeyStoreOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomKeyStoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TrentService.CreateCustomKeyStore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomKeyStoreOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCustomKeyStoreOutput, body, allocator);
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
