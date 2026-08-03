const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        already_exists_exception: AlreadyExistsException,
        cloud_hsm_cluster_in_use_exception: CloudHsmClusterInUseException,
        cloud_hsm_cluster_invalid_configuration_exception: CloudHsmClusterInvalidConfigurationException,
        cloud_hsm_cluster_not_active_exception: CloudHsmClusterNotActiveException,
        cloud_hsm_cluster_not_found_exception: CloudHsmClusterNotFoundException,
        cloud_hsm_cluster_not_related_exception: CloudHsmClusterNotRelatedException,
        conflict_exception: ConflictException,
        custom_key_store_has_cm_ks_exception: CustomKeyStoreHasCMKsException,
        custom_key_store_invalid_state_exception: CustomKeyStoreInvalidStateException,
        custom_key_store_name_in_use_exception: CustomKeyStoreNameInUseException,
        custom_key_store_not_found_exception: CustomKeyStoreNotFoundException,
        dependency_timeout_exception: DependencyTimeoutException,
        disabled_exception: DisabledException,
        dry_run_operation_exception: DryRunOperationException,
        expired_import_token_exception: ExpiredImportTokenException,
        incorrect_key_exception: IncorrectKeyException,
        incorrect_key_material_exception: IncorrectKeyMaterialException,
        incorrect_trust_anchor_exception: IncorrectTrustAnchorException,
        invalid_alias_name_exception: InvalidAliasNameException,
        invalid_arn_exception: InvalidArnException,
        invalid_ciphertext_exception: InvalidCiphertextException,
        invalid_grant_id_exception: InvalidGrantIdException,
        invalid_grant_token_exception: InvalidGrantTokenException,
        invalid_import_token_exception: InvalidImportTokenException,
        invalid_key_usage_exception: InvalidKeyUsageException,
        invalid_marker_exception: InvalidMarkerException,
        key_unavailable_exception: KeyUnavailableException,
        kms_internal_exception: KMSInternalException,
        kms_invalid_mac_exception: KMSInvalidMacException,
        kms_invalid_signature_exception: KMSInvalidSignatureException,
        kms_invalid_state_exception: KMSInvalidStateException,
        limit_exceeded_exception: LimitExceededException,
        malformed_policy_document_exception: MalformedPolicyDocumentException,
        not_found_exception: NotFoundException,
        tag_exception: TagException,
        unsupported_operation_exception: UnsupportedOperationException,
        xks_key_already_in_use_exception: XksKeyAlreadyInUseException,
        xks_key_invalid_configuration_exception: XksKeyInvalidConfigurationException,
        xks_key_not_found_exception: XksKeyNotFoundException,
        xks_proxy_incorrect_authentication_credential_exception: XksProxyIncorrectAuthenticationCredentialException,
        xks_proxy_invalid_configuration_exception: XksProxyInvalidConfigurationException,
        xks_proxy_invalid_response_exception: XksProxyInvalidResponseException,
        xks_proxy_uri_endpoint_in_use_exception: XksProxyUriEndpointInUseException,
        xks_proxy_uri_in_use_exception: XksProxyUriInUseException,
        xks_proxy_uri_unreachable_exception: XksProxyUriUnreachableException,
        xks_proxy_vpc_endpoint_service_in_use_exception: XksProxyVpcEndpointServiceInUseException,
        xks_proxy_vpc_endpoint_service_invalid_configuration_exception: XksProxyVpcEndpointServiceInvalidConfigurationException,
        xks_proxy_vpc_endpoint_service_not_found_exception: XksProxyVpcEndpointServiceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => "AlreadyExistsException",
                .cloud_hsm_cluster_in_use_exception => "CloudHsmClusterInUseException",
                .cloud_hsm_cluster_invalid_configuration_exception => "CloudHsmClusterInvalidConfigurationException",
                .cloud_hsm_cluster_not_active_exception => "CloudHsmClusterNotActiveException",
                .cloud_hsm_cluster_not_found_exception => "CloudHsmClusterNotFoundException",
                .cloud_hsm_cluster_not_related_exception => "CloudHsmClusterNotRelatedException",
                .conflict_exception => "ConflictException",
                .custom_key_store_has_cm_ks_exception => "CustomKeyStoreHasCMKsException",
                .custom_key_store_invalid_state_exception => "CustomKeyStoreInvalidStateException",
                .custom_key_store_name_in_use_exception => "CustomKeyStoreNameInUseException",
                .custom_key_store_not_found_exception => "CustomKeyStoreNotFoundException",
                .dependency_timeout_exception => "DependencyTimeoutException",
                .disabled_exception => "DisabledException",
                .dry_run_operation_exception => "DryRunOperationException",
                .expired_import_token_exception => "ExpiredImportTokenException",
                .incorrect_key_exception => "IncorrectKeyException",
                .incorrect_key_material_exception => "IncorrectKeyMaterialException",
                .incorrect_trust_anchor_exception => "IncorrectTrustAnchorException",
                .invalid_alias_name_exception => "InvalidAliasNameException",
                .invalid_arn_exception => "InvalidArnException",
                .invalid_ciphertext_exception => "InvalidCiphertextException",
                .invalid_grant_id_exception => "InvalidGrantIdException",
                .invalid_grant_token_exception => "InvalidGrantTokenException",
                .invalid_import_token_exception => "InvalidImportTokenException",
                .invalid_key_usage_exception => "InvalidKeyUsageException",
                .invalid_marker_exception => "InvalidMarkerException",
                .key_unavailable_exception => "KeyUnavailableException",
                .kms_internal_exception => "KMSInternalException",
                .kms_invalid_mac_exception => "KMSInvalidMacException",
                .kms_invalid_signature_exception => "KMSInvalidSignatureException",
                .kms_invalid_state_exception => "KMSInvalidStateException",
                .limit_exceeded_exception => "LimitExceededException",
                .malformed_policy_document_exception => "MalformedPolicyDocumentException",
                .not_found_exception => "NotFoundException",
                .tag_exception => "TagException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .xks_key_already_in_use_exception => "XksKeyAlreadyInUseException",
                .xks_key_invalid_configuration_exception => "XksKeyInvalidConfigurationException",
                .xks_key_not_found_exception => "XksKeyNotFoundException",
                .xks_proxy_incorrect_authentication_credential_exception => "XksProxyIncorrectAuthenticationCredentialException",
                .xks_proxy_invalid_configuration_exception => "XksProxyInvalidConfigurationException",
                .xks_proxy_invalid_response_exception => "XksProxyInvalidResponseException",
                .xks_proxy_uri_endpoint_in_use_exception => "XksProxyUriEndpointInUseException",
                .xks_proxy_uri_in_use_exception => "XksProxyUriInUseException",
                .xks_proxy_uri_unreachable_exception => "XksProxyUriUnreachableException",
                .xks_proxy_vpc_endpoint_service_in_use_exception => "XksProxyVpcEndpointServiceInUseException",
                .xks_proxy_vpc_endpoint_service_invalid_configuration_exception => "XksProxyVpcEndpointServiceInvalidConfigurationException",
                .xks_proxy_vpc_endpoint_service_not_found_exception => "XksProxyVpcEndpointServiceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.message,
                .cloud_hsm_cluster_in_use_exception => |e| e.message,
                .cloud_hsm_cluster_invalid_configuration_exception => |e| e.message,
                .cloud_hsm_cluster_not_active_exception => |e| e.message,
                .cloud_hsm_cluster_not_found_exception => |e| e.message,
                .cloud_hsm_cluster_not_related_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .custom_key_store_has_cm_ks_exception => |e| e.message,
                .custom_key_store_invalid_state_exception => |e| e.message,
                .custom_key_store_name_in_use_exception => |e| e.message,
                .custom_key_store_not_found_exception => |e| e.message,
                .dependency_timeout_exception => |e| e.message,
                .disabled_exception => |e| e.message,
                .dry_run_operation_exception => |e| e.message,
                .expired_import_token_exception => |e| e.message,
                .incorrect_key_exception => |e| e.message,
                .incorrect_key_material_exception => |e| e.message,
                .incorrect_trust_anchor_exception => |e| e.message,
                .invalid_alias_name_exception => |e| e.message,
                .invalid_arn_exception => |e| e.message,
                .invalid_ciphertext_exception => |e| e.message,
                .invalid_grant_id_exception => |e| e.message,
                .invalid_grant_token_exception => |e| e.message,
                .invalid_import_token_exception => |e| e.message,
                .invalid_key_usage_exception => |e| e.message,
                .invalid_marker_exception => |e| e.message,
                .key_unavailable_exception => |e| e.message,
                .kms_internal_exception => |e| e.message,
                .kms_invalid_mac_exception => |e| e.message,
                .kms_invalid_signature_exception => |e| e.message,
                .kms_invalid_state_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .malformed_policy_document_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .tag_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .xks_key_already_in_use_exception => |e| e.message,
                .xks_key_invalid_configuration_exception => |e| e.message,
                .xks_key_not_found_exception => |e| e.message,
                .xks_proxy_incorrect_authentication_credential_exception => |e| e.message,
                .xks_proxy_invalid_configuration_exception => |e| e.message,
                .xks_proxy_invalid_response_exception => |e| e.message,
                .xks_proxy_uri_endpoint_in_use_exception => |e| e.message,
                .xks_proxy_uri_in_use_exception => |e| e.message,
                .xks_proxy_uri_unreachable_exception => |e| e.message,
                .xks_proxy_vpc_endpoint_service_in_use_exception => |e| e.message,
                .xks_proxy_vpc_endpoint_service_invalid_configuration_exception => |e| e.message,
                .xks_proxy_vpc_endpoint_service_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .already_exists_exception => 409,
                .cloud_hsm_cluster_in_use_exception => 400,
                .cloud_hsm_cluster_invalid_configuration_exception => 400,
                .cloud_hsm_cluster_not_active_exception => 400,
                .cloud_hsm_cluster_not_found_exception => 400,
                .cloud_hsm_cluster_not_related_exception => 400,
                .conflict_exception => 409,
                .custom_key_store_has_cm_ks_exception => 400,
                .custom_key_store_invalid_state_exception => 400,
                .custom_key_store_name_in_use_exception => 400,
                .custom_key_store_not_found_exception => 400,
                .dependency_timeout_exception => 503,
                .disabled_exception => 409,
                .dry_run_operation_exception => 412,
                .expired_import_token_exception => 400,
                .incorrect_key_exception => 400,
                .incorrect_key_material_exception => 400,
                .incorrect_trust_anchor_exception => 400,
                .invalid_alias_name_exception => 400,
                .invalid_arn_exception => 400,
                .invalid_ciphertext_exception => 400,
                .invalid_grant_id_exception => 400,
                .invalid_grant_token_exception => 400,
                .invalid_import_token_exception => 400,
                .invalid_key_usage_exception => 400,
                .invalid_marker_exception => 400,
                .key_unavailable_exception => 500,
                .kms_internal_exception => 500,
                .kms_invalid_mac_exception => 400,
                .kms_invalid_signature_exception => 400,
                .kms_invalid_state_exception => 409,
                .limit_exceeded_exception => 400,
                .malformed_policy_document_exception => 400,
                .not_found_exception => 404,
                .tag_exception => 400,
                .unsupported_operation_exception => 400,
                .xks_key_already_in_use_exception => 400,
                .xks_key_invalid_configuration_exception => 400,
                .xks_key_not_found_exception => 400,
                .xks_proxy_incorrect_authentication_credential_exception => 400,
                .xks_proxy_invalid_configuration_exception => 400,
                .xks_proxy_invalid_response_exception => 400,
                .xks_proxy_uri_endpoint_in_use_exception => 400,
                .xks_proxy_uri_in_use_exception => 400,
                .xks_proxy_uri_unreachable_exception => 400,
                .xks_proxy_vpc_endpoint_service_in_use_exception => 400,
                .xks_proxy_vpc_endpoint_service_invalid_configuration_exception => 400,
                .xks_proxy_vpc_endpoint_service_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.request_id,
                .cloud_hsm_cluster_in_use_exception => |e| e.request_id,
                .cloud_hsm_cluster_invalid_configuration_exception => |e| e.request_id,
                .cloud_hsm_cluster_not_active_exception => |e| e.request_id,
                .cloud_hsm_cluster_not_found_exception => |e| e.request_id,
                .cloud_hsm_cluster_not_related_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .custom_key_store_has_cm_ks_exception => |e| e.request_id,
                .custom_key_store_invalid_state_exception => |e| e.request_id,
                .custom_key_store_name_in_use_exception => |e| e.request_id,
                .custom_key_store_not_found_exception => |e| e.request_id,
                .dependency_timeout_exception => |e| e.request_id,
                .disabled_exception => |e| e.request_id,
                .dry_run_operation_exception => |e| e.request_id,
                .expired_import_token_exception => |e| e.request_id,
                .incorrect_key_exception => |e| e.request_id,
                .incorrect_key_material_exception => |e| e.request_id,
                .incorrect_trust_anchor_exception => |e| e.request_id,
                .invalid_alias_name_exception => |e| e.request_id,
                .invalid_arn_exception => |e| e.request_id,
                .invalid_ciphertext_exception => |e| e.request_id,
                .invalid_grant_id_exception => |e| e.request_id,
                .invalid_grant_token_exception => |e| e.request_id,
                .invalid_import_token_exception => |e| e.request_id,
                .invalid_key_usage_exception => |e| e.request_id,
                .invalid_marker_exception => |e| e.request_id,
                .key_unavailable_exception => |e| e.request_id,
                .kms_internal_exception => |e| e.request_id,
                .kms_invalid_mac_exception => |e| e.request_id,
                .kms_invalid_signature_exception => |e| e.request_id,
                .kms_invalid_state_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .malformed_policy_document_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .tag_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
                .xks_key_already_in_use_exception => |e| e.request_id,
                .xks_key_invalid_configuration_exception => |e| e.request_id,
                .xks_key_not_found_exception => |e| e.request_id,
                .xks_proxy_incorrect_authentication_credential_exception => |e| e.request_id,
                .xks_proxy_invalid_configuration_exception => |e| e.request_id,
                .xks_proxy_invalid_response_exception => |e| e.request_id,
                .xks_proxy_uri_endpoint_in_use_exception => |e| e.request_id,
                .xks_proxy_uri_in_use_exception => |e| e.request_id,
                .xks_proxy_uri_unreachable_exception => |e| e.request_id,
                .xks_proxy_vpc_endpoint_service_in_use_exception => |e| e.request_id,
                .xks_proxy_vpc_endpoint_service_invalid_configuration_exception => |e| e.request_id,
                .xks_proxy_vpc_endpoint_service_not_found_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

/// The request was rejected because it attempted to create a resource that
/// already
/// exists.
pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified CloudHSM cluster is already
/// associated with an
/// CloudHSM key store in the account, or it shares a backup history with an
/// CloudHSM key store in the
/// account. Each CloudHSM key store in the account must be associated with a
/// different CloudHSM
/// cluster.
///
/// CloudHSM clusters that share a backup history have the same cluster
/// certificate. To view the
/// cluster certificate of an CloudHSM cluster, use the
/// [DescribeClusters](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html) operation.
pub const CloudHsmClusterInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the associated CloudHSM cluster did not
/// meet the
/// configuration requirements for an CloudHSM key store.
///
/// * The CloudHSM cluster must be configured with private subnets in at least
///   two different
/// Availability Zones in the Region.
///
/// * The [security group for
/// the
/// cluster](https://docs.aws.amazon.com/cloudhsm/latest/userguide/configure-sg.html) (cloudhsm-cluster-**-sg) must
/// include inbound rules and outbound rules that allow TCP traffic on ports
/// 2223-2225. The
/// **Source** in the inbound rules and the **Destination** in the outbound
/// rules must match the security group
/// ID. These rules are set by default when you create the CloudHSM cluster. Do
/// not delete or
/// change them. To get information about a particular security group, use the
/// [DescribeSecurityGroups](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSecurityGroups.html) operation.
///
/// * The CloudHSM cluster must contain at least as many HSMs as the operation
///   requires. To add
/// HSMs, use the CloudHSM
/// [CreateHsm](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_CreateHsm.html) operation.
///
/// For the CreateCustomKeyStore, UpdateCustomKeyStore, and CreateKey
/// operations, the CloudHSM cluster must have at least two
/// active HSMs, each in a different Availability Zone. For the
/// ConnectCustomKeyStore operation, the CloudHSM must contain at least one
/// active
/// HSM.
///
/// For information about the requirements for an CloudHSM cluster that is
/// associated with an
/// CloudHSM key store, see [Assemble the
/// Prerequisites](https://docs.aws.amazon.com/kms/latest/developerguide/create-keystore.html#before-keystore)
/// in the *Key Management Service Developer Guide*. For information about
/// creating a private subnet for an CloudHSM cluster,
/// see [Create a Private
/// Subnet](https://docs.aws.amazon.com/cloudhsm/latest/userguide/create-subnets.html) in the *CloudHSM User Guide*. For information about cluster security groups, see
/// [Configure a Default Security
/// Group](https://docs.aws.amazon.com/cloudhsm/latest/userguide/configure-sg.html) in the *
/// CloudHSM User Guide*
/// .
pub const CloudHsmClusterInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the CloudHSM cluster associated with the
/// CloudHSM key store is
/// not active. Initialize and activate the cluster and try the command again.
/// For detailed
/// instructions, see [Getting
/// Started](https://docs.aws.amazon.com/cloudhsm/latest/userguide/getting-started.html) in the *CloudHSM User Guide*.
pub const CloudHsmClusterNotActiveException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because KMS cannot find the CloudHSM cluster with
/// the specified
/// cluster ID. Retry the request with a different cluster ID.
pub const CloudHsmClusterNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified CloudHSM cluster has a
/// different cluster
/// certificate than the original cluster. You cannot use the operation to
/// specify an unrelated
/// cluster for an CloudHSM key store.
///
/// Specify an CloudHSM cluster that shares a backup history with the original
/// cluster. This
/// includes clusters that were created from a backup of the current cluster,
/// and clusters that
/// were created from the same backup that produced the current cluster.
///
/// CloudHSM clusters that share a backup history have the same cluster
/// certificate. To view the
/// cluster certificate of an CloudHSM cluster, use the
/// [DescribeClusters](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html) operation.
pub const CloudHsmClusterNotRelatedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because an automatic rotation of this key is
/// currently in
/// progress or scheduled to begin within the next 20 minutes.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the custom key store contains KMS keys.
/// After verifying
/// that you do not need to use the KMS keys, use the ScheduleKeyDeletion
/// operation to delete the KMS keys. After they are deleted, you can delete the
/// custom key
/// store.
pub const CustomKeyStoreHasCMKsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because of the `ConnectionState` of the custom key
/// store. To get the `ConnectionState` of a custom key store, use the
/// DescribeCustomKeyStores operation.
///
/// This exception is thrown under the following conditions:
///
/// * You requested the ConnectCustomKeyStore operation on a custom key
/// store with a `ConnectionState` of `DISCONNECTING` or
/// `FAILED`. This operation is valid for all other `ConnectionState`
/// values. To reconnect a custom key store in a `FAILED` state, disconnect it
/// (DisconnectCustomKeyStore), then connect it
/// (`ConnectCustomKeyStore`).
///
/// * You requested the CreateKey operation in a custom key store that is
/// not connected. This operations is valid only when the custom key store
/// `ConnectionState` is `CONNECTED`.
///
/// * You requested the DisconnectCustomKeyStore operation on a custom key
/// store with a `ConnectionState` of `DISCONNECTING` or
/// `DISCONNECTED`. This operation is valid for all other
/// `ConnectionState` values.
///
/// * You requested the UpdateCustomKeyStore or DeleteCustomKeyStore operation
///   on a custom key store that is not
/// disconnected. `UpdateCustomKeyStore` can be called on a custom key store in
/// the
/// `CONNECTED` state only to update `NewCustomKeyStoreName`.
/// For all other properties, the custom key store
/// `ConnectionState` must be `DISCONNECTED`.
///
/// * You requested the GenerateRandom operation in an CloudHSM key store
/// that is not connected. This operation is valid only when the CloudHSM key
/// store
/// `ConnectionState` is `CONNECTED`.
pub const CustomKeyStoreInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified custom key store name is
/// already assigned
/// to another custom key store in the account. Try again with a custom key
/// store name that is
/// unique in the account.
pub const CustomKeyStoreNameInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because KMS cannot find a custom key store with the
/// specified
/// key store name or ID.
pub const CustomKeyStoreNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The system timed out while trying to fulfill the request. You can retry the
/// request.
pub const DependencyTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified KMS key is not enabled.
pub const DisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the DryRun parameter was specified.
pub const DryRunOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified import token is expired. Use
/// GetParametersForImport to get a new import token and public key, use the new
/// public key to encrypt the key material, and then try the request again.
pub const ExpiredImportTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified KMS key cannot decrypt the
/// data. The
/// `KeyId` in a Decrypt request and the `SourceKeyId`
/// in a ReEncrypt request must identify the same KMS key that was used to
/// encrypt the ciphertext.
pub const IncorrectKeyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the key material in the request is,
/// expired, invalid, or
/// does not meet expectations. For example, it is not the same key material
/// that was previously
/// imported or KMS expected new key material but the key material being
/// imported is already
/// associated with the KMS key.
pub const IncorrectKeyMaterialException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the trust anchor certificate in the request
/// to create an
/// CloudHSM key store is not the trust anchor certificate for the specified
/// CloudHSM cluster.
///
/// When you [initialize the CloudHSM
/// cluster](https://docs.aws.amazon.com/cloudhsm/latest/userguide/initialize-cluster.html#sign-csr), you create the trust anchor certificate and save it
/// in the `customerCA.crt` file.
pub const IncorrectTrustAnchorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified alias name is not valid.
pub const InvalidAliasNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because a specified ARN, or an ARN in a key policy,
/// is not
/// valid.
pub const InvalidArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// From the Decrypt or ReEncrypt operation, the request
/// was rejected because the specified ciphertext, or additional authenticated
/// data incorporated
/// into the ciphertext, such as the encryption context, is corrupted, missing,
/// or otherwise
/// invalid.
///
/// From the ImportKeyMaterial operation, the request was rejected because
/// KMS could not decrypt the encrypted (wrapped) key material.
pub const InvalidCiphertextException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified `GrantId` is not valid.
pub const InvalidGrantIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified grant token is not valid.
pub const InvalidGrantTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the provided import token is invalid or is
/// associated
/// with a different KMS key.
pub const InvalidImportTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected for one of the following reasons:
///
/// * The `KeyUsage` value of the KMS key is incompatible with the API
/// operation.
///
/// * The encryption algorithm or signing algorithm specified for the operation
///   is
/// incompatible with the type of key material in the KMS key `(KeySpec`).
///
/// For encrypting, decrypting, re-encrypting, and generating data keys, the
/// `KeyUsage` must be `ENCRYPT_DECRYPT`. For signing and verifying
/// messages, the `KeyUsage` must be `SIGN_VERIFY`. For generating and
/// verifying message authentication codes (MACs), the `KeyUsage` must be
/// `GENERATE_VERIFY_MAC`. For deriving key agreement secrets, the
/// `KeyUsage` must be `KEY_AGREEMENT`. To find the `KeyUsage`
/// of a KMS key, use the DescribeKey operation.
///
/// To find the encryption or signing algorithms supported for a particular KMS
/// key, use the
/// DescribeKey operation.
pub const InvalidKeyUsageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the marker that specifies where pagination
/// should next
/// begin is not valid.
pub const InvalidMarkerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified KMS key was not available.
/// You can retry
/// the request.
pub const KeyUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because an internal exception occurred. The request
/// can be
/// retried.
pub const KMSInternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the HMAC verification failed. HMAC
/// verification fails
/// when the HMAC computed by using the specified message, HMAC KMS key, and MAC
/// algorithm does
/// not match the HMAC specified in the request.
pub const KMSInvalidMacException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the signature verification failed.
/// Signature verification
/// fails when it cannot confirm that signature was produced by signing the
/// specified message with
/// the specified KMS key and signing algorithm.
pub const KMSInvalidSignatureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the state of the specified resource is not
/// valid for this
/// request.
///
/// This exceptions means one of the following:
///
/// * The key state of the KMS key is not compatible with the operation.
///
/// To find the key state, use the DescribeKey operation. For more
/// information about which key states are compatible with each KMS operation,
/// see
/// [Key states of KMS
/// keys](https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html)
/// in the *
/// Key Management Service Developer Guide*
/// .
///
/// * For cryptographic operations on KMS keys in custom key stores, this
///   exception
/// represents a general failure with many possible causes. To identify the
/// cause, see the
/// error message that accompanies the exception.
pub const KMSInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because a length constraint or quota was exceeded.
/// For more
/// information, see
/// [Quotas](https://docs.aws.amazon.com/kms/latest/developerguide/limits.html)
/// in
/// the *Key Management Service Developer Guide*.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified policy is not syntactically
/// or semantically
/// correct.
pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified entity or resource could not
/// be
/// found.
pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because one or more tags are not valid.
pub const TagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because a specified parameter is not supported or a
/// specified
/// resource is not valid for this operation.
pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the (`XksKeyId`) is already associated with
/// another KMS key in this external key store. Each KMS key in an external key
/// store must be
/// associated with a different external key.
pub const XksKeyAlreadyInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the external key specified by the
/// `XksKeyId`
/// parameter did not meet the configuration requirements for an external key
/// store.
///
/// The external key must be an AES-256 symmetric key that is enabled and
/// performs encryption
/// and decryption.
pub const XksKeyInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the external key store proxy could not find
/// the external
/// key. This exception is thrown when the value of the `XksKeyId` parameter
/// doesn't
/// identify a key in the external key manager associated with the external key
/// proxy.
///
/// Verify that the `XksKeyId` represents an existing key in the external key
/// manager. Use the key identifier that the external key store proxy uses to
/// identify the key.
/// For details, see the documentation provided with your external key store
/// proxy or key
/// manager.
pub const XksKeyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the proxy credentials failed to
/// authenticate to the
/// specified external key store proxy. The specified external key store proxy
/// rejected a status
/// request from KMS due to invalid credentials. This can indicate an error in
/// the credentials
/// or in the identification of the external key store proxy.
pub const XksProxyIncorrectAuthenticationCredentialException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the external key store proxy is not
/// configured correctly.
/// To identify the cause, see the error message that accompanies the exception.
pub const XksProxyInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// KMS cannot interpret the response it received from the external key store
/// proxy. The
/// problem might be a poorly constructed response, but it could also be a
/// transient network
/// issue. If you see this error repeatedly, report it to the proxy vendor.
pub const XksProxyInvalidResponseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the `XksProxyUriEndpoint` is already
/// associated with another external key store in this Amazon Web Services
/// Region. To identify the cause, see
/// the error message that accompanies the exception.
pub const XksProxyUriEndpointInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the concatenation of the
/// `XksProxyUriEndpoint`
/// and `XksProxyUriPath` is already associated with another external key store
/// in this
/// Amazon Web Services Region. Each external key store in a Region must use a
/// unique external key store proxy
/// API address.
pub const XksProxyUriInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// KMS was unable to reach the specified `XksProxyUriPath`. The path must be
/// reachable before you create the external key store or update its settings.
///
/// This exception is also thrown when the external key store proxy response to
/// a
/// `GetHealthStatus` request indicates that all external key manager instances
/// are
/// unavailable.
pub const XksProxyUriUnreachableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified Amazon VPC endpoint service
/// is already
/// associated with another external key store in this Amazon Web Services
/// Region. Each external key store in a
/// Region must use a different Amazon VPC endpoint service.
pub const XksProxyVpcEndpointServiceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the Amazon VPC endpoint service
/// configuration does not fulfill
/// the requirements for an external key store. To identify the cause, see the
/// error message that
/// accompanies the exception and [review the
/// requirements](https://docs.aws.amazon.com/kms/latest/developerguide/vpc-connectivity.html#xks-vpc-requirements) for Amazon VPC endpoint service connectivity for an external key
/// store.
pub const XksProxyVpcEndpointServiceInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because KMS could not find the specified VPC
/// endpoint service.
/// Use DescribeCustomKeyStores to verify the VPC endpoint service name for the
/// external key store. Also, confirm that the `Allow principals` list for the
/// VPC
/// endpoint service includes the KMS service principal for the Region, such as
/// `cks.kms.us-east-1.amazonaws.com`.
pub const XksProxyVpcEndpointServiceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
