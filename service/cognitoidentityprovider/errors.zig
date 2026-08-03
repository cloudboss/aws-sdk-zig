const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
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
        internal_server_exception: InternalServerException,
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
                .access_denied_exception => "AccessDeniedException",
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
                .internal_server_exception => "InternalServerException",
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
                .access_denied_exception => |e| e.message,
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
                .internal_server_exception => |e| e.message,
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
                .access_denied_exception => 403,
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
                .internal_server_exception => 500,
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
                .access_denied_exception => |e| e.request_id,
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
                .internal_server_exception => |e| e.request_id,
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

/// This exception is thrown when you don't have sufficient permissions to
/// perform the requested operation.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a user tries to confirm the account with an
/// email
/// address or phone number that has already been supplied as an alias for a
/// different user
/// profile. This exception indicates that an account with this email address or
/// phone
/// already exists in a user pool that you've configured to use email address or
/// phone
/// number as a sign-in alias.
pub const AliasExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a verification code fails to deliver
/// successfully.
pub const CodeDeliveryFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown if the provided code doesn't match what the server
/// was
/// expecting.
pub const CodeMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown if two or more modifications are happening
/// concurrently.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a user attempts to confirm a device with a
/// device key
/// that already exists.
pub const DeviceKeyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the provider is already supported by the user
/// pool.
pub const DuplicateProviderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when there is a code mismatch and the service fails
/// to
/// configure the software token TOTP multi-factor authentication (MFA).
pub const EnableSoftwareTokenMFAException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown if a code has expired.
pub const ExpiredCodeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a feature you attempted to configure isn't
/// available in your current feature plan.
pub const FeatureUnavailableInTierException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when WAF doesn't allow your request based on a web
/// ACL that's associated with your user pool.
pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when Amazon Cognito encounters a group that already
/// exists in the user
/// pool.
pub const GroupExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when Amazon Cognito encounters an internal error.
pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when Amazon Cognito encounters an internal server
/// error.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when Amazon Cognito isn't allowed to use your email
/// identity. HTTP
/// status code: 400.
pub const InvalidEmailRoleAccessPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when Amazon Cognito encounters an invalid Lambda
/// response.
pub const InvalidLambdaResponseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the specified OAuth flow is not valid.
pub const InvalidOAuthFlowException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the Amazon Cognito service encounters an
/// invalid
/// parameter.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The reason code of the exception.
    reason_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .reason_code = "reasonCode",
    };
};

/// This exception is thrown when Amazon Cognito encounters an invalid password.
pub const InvalidPasswordException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is returned when the role provided for SMS configuration
/// doesn't have
/// permission to publish using Amazon SNS.
pub const InvalidSmsRoleAccessPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the trust relationship is not valid for the
/// role
/// provided for SMS configuration. This can happen if you don't trust
/// `cognito-idp.amazonaws.com` or the external ID provided in the role does
/// not match what is provided in the SMS configuration for the user pool.
pub const InvalidSmsRoleTrustRelationshipException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the user pool configuration is not valid.
pub const InvalidUserPoolConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a user exceeds the limit for a requested
/// Amazon Web Services
/// resource.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when you attempt to apply a managed login branding
/// style to
/// an app client that already has an assigned style.
pub const ManagedLoginBrandingExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when Amazon Cognito can't find a multi-factor
/// authentication
/// (MFA) method.
pub const MFAMethodNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a user isn't authorized.
pub const NotAuthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The message returned when a user's new password matches a previous password
/// and
/// doesn't comply with the password-history policy.
pub const PasswordHistoryPolicyViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a password reset is required.
pub const PasswordResetRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a precondition is not met.
pub const PreconditionNotMetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is throw when your application requests token refresh with a
/// refresh
/// token that has been invalidated by refresh-token rotation.
pub const RefreshTokenReuseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the Amazon Cognito service can't find the
/// requested
/// resource.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the specified scope doesn't exist.
pub const ScopeDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the software token time-based one-time
/// password (TOTP)
/// multi-factor authentication (MFA) isn't activated for the user pool.
pub const SoftwareTokenMFANotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Terms document names must be unique to the app client. This exception is
/// thrown when
/// you attempt to create terms documents with a duplicate `TermsName`.
pub const TermsExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when you've attempted to change your feature plan
/// but
/// the operation isn't permitted.
pub const TierChangeNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the user has made too many failed attempts for
/// a given
/// action, such as sign-in.
pub const TooManyFailedAttemptsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the user has made too many requests for a
/// given
/// operation.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception that is thrown when the request isn't authorized. This can happen
/// due to an
/// invalid access token in the request.
pub const UnauthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when Amazon Cognito encounters an unexpected
/// exception with
/// Lambda.
pub const UnexpectedLambdaException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the specified identifier isn't supported.
pub const UnsupportedIdentityProviderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception that is thrown when you attempt to perform an operation that isn't
/// enabled
/// for the user pool client.
pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception that is thrown when an unsupported token is passed to an
/// operation.
pub const UnsupportedTokenTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request failed because the user is in an unsupported state.
pub const UnsupportedUserStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when you're trying to modify a user pool while a
/// user import
/// job is in progress for that pool.
pub const UserImportInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the Amazon Cognito service encounters a user
/// validation exception
/// with the Lambda service.
pub const UserLambdaValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a user isn't confirmed successfully.
pub const UserNotConfirmedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a user isn't found.
pub const UserNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when user pool add-ons aren't enabled.
pub const UserPoolAddOnNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a user pool tag can't be set or updated.
pub const UserPoolTaggingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when Amazon Cognito encounters a user name that
/// already
/// exists in the user pool.
pub const UsernameExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the challenge from `StartWebAuthn`
/// registration has expired.
pub const WebAuthnChallengeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the access token is for a different client
/// than the one
/// in the original `StartWebAuthnRegistration` request.
pub const WebAuthnClientMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a user pool doesn't have a configured relying
/// party
/// id or a user pool domain.
pub const WebAuthnConfigurationMissingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when a user presents passkey credentials from an
/// unsupported
/// device or provider.
pub const WebAuthnCredentialNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the passkey feature isn't enabled for the user
/// pool.
pub const WebAuthnNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the passkey credential's registration origin
/// does not
/// align with the user pool relying party id.
pub const WebAuthnOriginNotAllowedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception is thrown when the given passkey credential is associated
/// with a
/// different relying party ID than the user pool relying party ID.
pub const WebAuthnRelyingPartyMismatchException = struct {
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
