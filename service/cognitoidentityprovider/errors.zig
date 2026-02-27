const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        alias_exists_exception: AliasExistsException,
        code_delivery_failure_exception: CodeDeliveryFailureException,
        code_mismatch_exception: CodeMismatchException,
        concurrent_modification_exception: ConcurrentModificationException,
        device_key_exists_exception: DeviceKeyExistsException,
        duplicate_provider_exception: DuplicateProviderException,
        enable_software_token_mfa_exception: EnableSoftwareTokenMFAException,
        expired_code_exception: ExpiredCodeException,
        feature_unavailable_in_tier_exception: FeatureUnavailableInTierException,
        forbidden_exception: ForbiddenException,
        group_exists_exception: GroupExistsException,
        internal_error_exception: InternalErrorException,
        invalid_email_role_access_policy_exception: InvalidEmailRoleAccessPolicyException,
        invalid_lambda_response_exception: InvalidLambdaResponseException,
        invalid_o_auth_flow_exception: InvalidOAuthFlowException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_password_exception: InvalidPasswordException,
        invalid_sms_role_access_policy_exception: InvalidSmsRoleAccessPolicyException,
        invalid_sms_role_trust_relationship_exception: InvalidSmsRoleTrustRelationshipException,
        invalid_user_pool_configuration_exception: InvalidUserPoolConfigurationException,
        limit_exceeded_exception: LimitExceededException,
        managed_login_branding_exists_exception: ManagedLoginBrandingExistsException,
        mfa_method_not_found_exception: MFAMethodNotFoundException,
        not_authorized_exception: NotAuthorizedException,
        password_history_policy_violation_exception: PasswordHistoryPolicyViolationException,
        password_reset_required_exception: PasswordResetRequiredException,
        precondition_not_met_exception: PreconditionNotMetException,
        refresh_token_reuse_exception: RefreshTokenReuseException,
        resource_not_found_exception: ResourceNotFoundException,
        scope_does_not_exist_exception: ScopeDoesNotExistException,
        software_token_mfa_not_found_exception: SoftwareTokenMFANotFoundException,
        terms_exists_exception: TermsExistsException,
        tier_change_not_allowed_exception: TierChangeNotAllowedException,
        too_many_failed_attempts_exception: TooManyFailedAttemptsException,
        too_many_requests_exception: TooManyRequestsException,
        unauthorized_exception: UnauthorizedException,
        unexpected_lambda_exception: UnexpectedLambdaException,
        unsupported_identity_provider_exception: UnsupportedIdentityProviderException,
        unsupported_operation_exception: UnsupportedOperationException,
        unsupported_token_type_exception: UnsupportedTokenTypeException,
        unsupported_user_state_exception: UnsupportedUserStateException,
        user_import_in_progress_exception: UserImportInProgressException,
        user_lambda_validation_exception: UserLambdaValidationException,
        user_not_confirmed_exception: UserNotConfirmedException,
        user_not_found_exception: UserNotFoundException,
        user_pool_add_on_not_enabled_exception: UserPoolAddOnNotEnabledException,
        user_pool_tagging_exception: UserPoolTaggingException,
        username_exists_exception: UsernameExistsException,
        web_authn_challenge_not_found_exception: WebAuthnChallengeNotFoundException,
        web_authn_client_mismatch_exception: WebAuthnClientMismatchException,
        web_authn_configuration_missing_exception: WebAuthnConfigurationMissingException,
        web_authn_credential_not_supported_exception: WebAuthnCredentialNotSupportedException,
        web_authn_not_enabled_exception: WebAuthnNotEnabledException,
        web_authn_origin_not_allowed_exception: WebAuthnOriginNotAllowedException,
        web_authn_relying_party_mismatch_exception: WebAuthnRelyingPartyMismatchException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .alias_exists_exception => "AliasExistsException",
                .code_delivery_failure_exception => "CodeDeliveryFailureException",
                .code_mismatch_exception => "CodeMismatchException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .device_key_exists_exception => "DeviceKeyExistsException",
                .duplicate_provider_exception => "DuplicateProviderException",
                .enable_software_token_mfa_exception => "EnableSoftwareTokenMFAException",
                .expired_code_exception => "ExpiredCodeException",
                .feature_unavailable_in_tier_exception => "FeatureUnavailableInTierException",
                .forbidden_exception => "ForbiddenException",
                .group_exists_exception => "GroupExistsException",
                .internal_error_exception => "InternalErrorException",
                .invalid_email_role_access_policy_exception => "InvalidEmailRoleAccessPolicyException",
                .invalid_lambda_response_exception => "InvalidLambdaResponseException",
                .invalid_o_auth_flow_exception => "InvalidOAuthFlowException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_password_exception => "InvalidPasswordException",
                .invalid_sms_role_access_policy_exception => "InvalidSmsRoleAccessPolicyException",
                .invalid_sms_role_trust_relationship_exception => "InvalidSmsRoleTrustRelationshipException",
                .invalid_user_pool_configuration_exception => "InvalidUserPoolConfigurationException",
                .limit_exceeded_exception => "LimitExceededException",
                .managed_login_branding_exists_exception => "ManagedLoginBrandingExistsException",
                .mfa_method_not_found_exception => "MFAMethodNotFoundException",
                .not_authorized_exception => "NotAuthorizedException",
                .password_history_policy_violation_exception => "PasswordHistoryPolicyViolationException",
                .password_reset_required_exception => "PasswordResetRequiredException",
                .precondition_not_met_exception => "PreconditionNotMetException",
                .refresh_token_reuse_exception => "RefreshTokenReuseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .scope_does_not_exist_exception => "ScopeDoesNotExistException",
                .software_token_mfa_not_found_exception => "SoftwareTokenMFANotFoundException",
                .terms_exists_exception => "TermsExistsException",
                .tier_change_not_allowed_exception => "TierChangeNotAllowedException",
                .too_many_failed_attempts_exception => "TooManyFailedAttemptsException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unauthorized_exception => "UnauthorizedException",
                .unexpected_lambda_exception => "UnexpectedLambdaException",
                .unsupported_identity_provider_exception => "UnsupportedIdentityProviderException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unsupported_token_type_exception => "UnsupportedTokenTypeException",
                .unsupported_user_state_exception => "UnsupportedUserStateException",
                .user_import_in_progress_exception => "UserImportInProgressException",
                .user_lambda_validation_exception => "UserLambdaValidationException",
                .user_not_confirmed_exception => "UserNotConfirmedException",
                .user_not_found_exception => "UserNotFoundException",
                .user_pool_add_on_not_enabled_exception => "UserPoolAddOnNotEnabledException",
                .user_pool_tagging_exception => "UserPoolTaggingException",
                .username_exists_exception => "UsernameExistsException",
                .web_authn_challenge_not_found_exception => "WebAuthnChallengeNotFoundException",
                .web_authn_client_mismatch_exception => "WebAuthnClientMismatchException",
                .web_authn_configuration_missing_exception => "WebAuthnConfigurationMissingException",
                .web_authn_credential_not_supported_exception => "WebAuthnCredentialNotSupportedException",
                .web_authn_not_enabled_exception => "WebAuthnNotEnabledException",
                .web_authn_origin_not_allowed_exception => "WebAuthnOriginNotAllowedException",
                .web_authn_relying_party_mismatch_exception => "WebAuthnRelyingPartyMismatchException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .alias_exists_exception => |e| e.message,
                .code_delivery_failure_exception => |e| e.message,
                .code_mismatch_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .device_key_exists_exception => |e| e.message,
                .duplicate_provider_exception => |e| e.message,
                .enable_software_token_mfa_exception => |e| e.message,
                .expired_code_exception => |e| e.message,
                .feature_unavailable_in_tier_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .group_exists_exception => |e| e.message,
                .internal_error_exception => |e| e.message,
                .invalid_email_role_access_policy_exception => |e| e.message,
                .invalid_lambda_response_exception => |e| e.message,
                .invalid_o_auth_flow_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_password_exception => |e| e.message,
                .invalid_sms_role_access_policy_exception => |e| e.message,
                .invalid_sms_role_trust_relationship_exception => |e| e.message,
                .invalid_user_pool_configuration_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .managed_login_branding_exists_exception => |e| e.message,
                .mfa_method_not_found_exception => |e| e.message,
                .not_authorized_exception => |e| e.message,
                .password_history_policy_violation_exception => |e| e.message,
                .password_reset_required_exception => |e| e.message,
                .precondition_not_met_exception => |e| e.message,
                .refresh_token_reuse_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .scope_does_not_exist_exception => |e| e.message,
                .software_token_mfa_not_found_exception => |e| e.message,
                .terms_exists_exception => |e| e.message,
                .tier_change_not_allowed_exception => |e| e.message,
                .too_many_failed_attempts_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .unexpected_lambda_exception => |e| e.message,
                .unsupported_identity_provider_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unsupported_token_type_exception => |e| e.message,
                .unsupported_user_state_exception => |e| e.message,
                .user_import_in_progress_exception => |e| e.message,
                .user_lambda_validation_exception => |e| e.message,
                .user_not_confirmed_exception => |e| e.message,
                .user_not_found_exception => |e| e.message,
                .user_pool_add_on_not_enabled_exception => |e| e.message,
                .user_pool_tagging_exception => |e| e.message,
                .username_exists_exception => |e| e.message,
                .web_authn_challenge_not_found_exception => |e| e.message,
                .web_authn_client_mismatch_exception => |e| e.message,
                .web_authn_configuration_missing_exception => |e| e.message,
                .web_authn_credential_not_supported_exception => |e| e.message,
                .web_authn_not_enabled_exception => |e| e.message,
                .web_authn_origin_not_allowed_exception => |e| e.message,
                .web_authn_relying_party_mismatch_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .alias_exists_exception => 400,
                .code_delivery_failure_exception => 400,
                .code_mismatch_exception => 400,
                .concurrent_modification_exception => 400,
                .device_key_exists_exception => 400,
                .duplicate_provider_exception => 400,
                .enable_software_token_mfa_exception => 400,
                .expired_code_exception => 400,
                .feature_unavailable_in_tier_exception => 403,
                .forbidden_exception => 403,
                .group_exists_exception => 400,
                .internal_error_exception => 500,
                .invalid_email_role_access_policy_exception => 400,
                .invalid_lambda_response_exception => 400,
                .invalid_o_auth_flow_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_password_exception => 400,
                .invalid_sms_role_access_policy_exception => 400,
                .invalid_sms_role_trust_relationship_exception => 400,
                .invalid_user_pool_configuration_exception => 400,
                .limit_exceeded_exception => 400,
                .managed_login_branding_exists_exception => 400,
                .mfa_method_not_found_exception => 400,
                .not_authorized_exception => 403,
                .password_history_policy_violation_exception => 400,
                .password_reset_required_exception => 400,
                .precondition_not_met_exception => 400,
                .refresh_token_reuse_exception => 400,
                .resource_not_found_exception => 404,
                .scope_does_not_exist_exception => 400,
                .software_token_mfa_not_found_exception => 400,
                .terms_exists_exception => 400,
                .tier_change_not_allowed_exception => 403,
                .too_many_failed_attempts_exception => 400,
                .too_many_requests_exception => 429,
                .unauthorized_exception => 401,
                .unexpected_lambda_exception => 400,
                .unsupported_identity_provider_exception => 400,
                .unsupported_operation_exception => 400,
                .unsupported_token_type_exception => 400,
                .unsupported_user_state_exception => 400,
                .user_import_in_progress_exception => 400,
                .user_lambda_validation_exception => 400,
                .user_not_confirmed_exception => 400,
                .user_not_found_exception => 404,
                .user_pool_add_on_not_enabled_exception => 400,
                .user_pool_tagging_exception => 400,
                .username_exists_exception => 400,
                .web_authn_challenge_not_found_exception => 400,
                .web_authn_client_mismatch_exception => 400,
                .web_authn_configuration_missing_exception => 400,
                .web_authn_credential_not_supported_exception => 400,
                .web_authn_not_enabled_exception => 400,
                .web_authn_origin_not_allowed_exception => 400,
                .web_authn_relying_party_mismatch_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .alias_exists_exception => |e| e.request_id,
                .code_delivery_failure_exception => |e| e.request_id,
                .code_mismatch_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .device_key_exists_exception => |e| e.request_id,
                .duplicate_provider_exception => |e| e.request_id,
                .enable_software_token_mfa_exception => |e| e.request_id,
                .expired_code_exception => |e| e.request_id,
                .feature_unavailable_in_tier_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .group_exists_exception => |e| e.request_id,
                .internal_error_exception => |e| e.request_id,
                .invalid_email_role_access_policy_exception => |e| e.request_id,
                .invalid_lambda_response_exception => |e| e.request_id,
                .invalid_o_auth_flow_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_password_exception => |e| e.request_id,
                .invalid_sms_role_access_policy_exception => |e| e.request_id,
                .invalid_sms_role_trust_relationship_exception => |e| e.request_id,
                .invalid_user_pool_configuration_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .managed_login_branding_exists_exception => |e| e.request_id,
                .mfa_method_not_found_exception => |e| e.request_id,
                .not_authorized_exception => |e| e.request_id,
                .password_history_policy_violation_exception => |e| e.request_id,
                .password_reset_required_exception => |e| e.request_id,
                .precondition_not_met_exception => |e| e.request_id,
                .refresh_token_reuse_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .scope_does_not_exist_exception => |e| e.request_id,
                .software_token_mfa_not_found_exception => |e| e.request_id,
                .terms_exists_exception => |e| e.request_id,
                .tier_change_not_allowed_exception => |e| e.request_id,
                .too_many_failed_attempts_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
                .unexpected_lambda_exception => |e| e.request_id,
                .unsupported_identity_provider_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
                .unsupported_token_type_exception => |e| e.request_id,
                .unsupported_user_state_exception => |e| e.request_id,
                .user_import_in_progress_exception => |e| e.request_id,
                .user_lambda_validation_exception => |e| e.request_id,
                .user_not_confirmed_exception => |e| e.request_id,
                .user_not_found_exception => |e| e.request_id,
                .user_pool_add_on_not_enabled_exception => |e| e.request_id,
                .user_pool_tagging_exception => |e| e.request_id,
                .username_exists_exception => |e| e.request_id,
                .web_authn_challenge_not_found_exception => |e| e.request_id,
                .web_authn_client_mismatch_exception => |e| e.request_id,
                .web_authn_configuration_missing_exception => |e| e.request_id,
                .web_authn_credential_not_supported_exception => |e| e.request_id,
                .web_authn_not_enabled_exception => |e| e.request_id,
                .web_authn_origin_not_allowed_exception => |e| e.request_id,
                .web_authn_relying_party_mismatch_exception => |e| e.request_id,
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

pub const AliasExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CodeDeliveryFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CodeMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeviceKeyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateProviderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EnableSoftwareTokenMFAException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExpiredCodeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FeatureUnavailableInTierException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GroupExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEmailRoleAccessPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLambdaResponseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOAuthFlowException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPasswordException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSmsRoleAccessPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSmsRoleTrustRelationshipException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidUserPoolConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ManagedLoginBrandingExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MFAMethodNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotAuthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PasswordHistoryPolicyViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PasswordResetRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PreconditionNotMetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RefreshTokenReuseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ScopeDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SoftwareTokenMFANotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TermsExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TierChangeNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyFailedAttemptsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnexpectedLambdaException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedIdentityProviderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedTokenTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedUserStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserImportInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserLambdaValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserNotConfirmedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserPoolAddOnNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserPoolTaggingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UsernameExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WebAuthnChallengeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WebAuthnClientMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WebAuthnConfigurationMissingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WebAuthnCredentialNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WebAuthnNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WebAuthnOriginNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WebAuthnRelyingPartyMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
