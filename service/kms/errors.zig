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

pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudHsmClusterInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudHsmClusterInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudHsmClusterNotActiveException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudHsmClusterNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CloudHsmClusterNotRelatedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomKeyStoreHasCMKsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomKeyStoreInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomKeyStoreNameInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomKeyStoreNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DependencyTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DryRunOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExpiredImportTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncorrectKeyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncorrectKeyMaterialException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncorrectTrustAnchorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAliasNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCiphertextException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGrantIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGrantTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidImportTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidKeyUsageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMarkerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KeyUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSInternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSInvalidMacException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSInvalidSignatureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksKeyAlreadyInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksKeyInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksKeyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksProxyIncorrectAuthenticationCredentialException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksProxyInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksProxyInvalidResponseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksProxyUriEndpointInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksProxyUriInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksProxyUriUnreachableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksProxyVpcEndpointServiceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksProxyVpcEndpointServiceInvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const XksProxyVpcEndpointServiceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
