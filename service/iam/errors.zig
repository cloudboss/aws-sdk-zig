const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        account_not_management_or_delegated_administrator_exception: AccountNotManagementOrDelegatedAdministratorException,
        caller_is_not_management_account_exception: CallerIsNotManagementAccountException,
        concurrent_modification_exception: ConcurrentModificationException,
        credential_report_expired_exception: CredentialReportExpiredException,
        credential_report_not_present_exception: CredentialReportNotPresentException,
        credential_report_not_ready_exception: CredentialReportNotReadyException,
        delete_conflict_exception: DeleteConflictException,
        duplicate_certificate_exception: DuplicateCertificateException,
        duplicate_ssh_public_key_exception: DuplicateSSHPublicKeyException,
        entity_already_exists_exception: EntityAlreadyExistsException,
        entity_temporarily_unmodifiable_exception: EntityTemporarilyUnmodifiableException,
        feature_disabled_exception: FeatureDisabledException,
        feature_enabled_exception: FeatureEnabledException,
        invalid_authentication_code_exception: InvalidAuthenticationCodeException,
        invalid_certificate_exception: InvalidCertificateException,
        invalid_input_exception: InvalidInputException,
        invalid_public_key_exception: InvalidPublicKeyException,
        invalid_user_type_exception: InvalidUserTypeException,
        key_pair_mismatch_exception: KeyPairMismatchException,
        limit_exceeded_exception: LimitExceededException,
        malformed_certificate_exception: MalformedCertificateException,
        malformed_policy_document_exception: MalformedPolicyDocumentException,
        name_conflict_exception: NameConflictException,
        no_such_entity_exception: NoSuchEntityException,
        open_id_idp_communication_error_exception: OpenIdIdpCommunicationErrorException,
        organization_not_found_exception: OrganizationNotFoundException,
        organization_not_in_all_features_mode_exception: OrganizationNotInAllFeaturesModeException,
        password_policy_violation_exception: PasswordPolicyViolationException,
        policy_evaluation_exception: PolicyEvaluationException,
        policy_not_attachable_exception: PolicyNotAttachableException,
        report_generation_limit_exceeded_exception: ReportGenerationLimitExceededException,
        role_modified_exception: RoleModifiedException,
        role_template_disabled_exception: RoleTemplateDisabledException,
        service_access_not_enabled_exception: ServiceAccessNotEnabledException,
        service_failure_exception: ServiceFailureException,
        service_not_supported_exception: ServiceNotSupportedException,
        unmodifiable_entity_exception: UnmodifiableEntityException,
        unrecognized_public_key_encoding_exception: UnrecognizedPublicKeyEncodingException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .account_not_management_or_delegated_administrator_exception => "AccountNotManagementOrDelegatedAdministratorException",
                .caller_is_not_management_account_exception => "CallerIsNotManagementAccountException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .credential_report_expired_exception => "CredentialReportExpiredException",
                .credential_report_not_present_exception => "CredentialReportNotPresentException",
                .credential_report_not_ready_exception => "CredentialReportNotReadyException",
                .delete_conflict_exception => "DeleteConflictException",
                .duplicate_certificate_exception => "DuplicateCertificateException",
                .duplicate_ssh_public_key_exception => "DuplicateSSHPublicKeyException",
                .entity_already_exists_exception => "EntityAlreadyExistsException",
                .entity_temporarily_unmodifiable_exception => "EntityTemporarilyUnmodifiableException",
                .feature_disabled_exception => "FeatureDisabledException",
                .feature_enabled_exception => "FeatureEnabledException",
                .invalid_authentication_code_exception => "InvalidAuthenticationCodeException",
                .invalid_certificate_exception => "InvalidCertificateException",
                .invalid_input_exception => "InvalidInputException",
                .invalid_public_key_exception => "InvalidPublicKeyException",
                .invalid_user_type_exception => "InvalidUserTypeException",
                .key_pair_mismatch_exception => "KeyPairMismatchException",
                .limit_exceeded_exception => "LimitExceededException",
                .malformed_certificate_exception => "MalformedCertificateException",
                .malformed_policy_document_exception => "MalformedPolicyDocumentException",
                .name_conflict_exception => "NameConflictException",
                .no_such_entity_exception => "NoSuchEntityException",
                .open_id_idp_communication_error_exception => "OpenIdIdpCommunicationErrorException",
                .organization_not_found_exception => "OrganizationNotFoundException",
                .organization_not_in_all_features_mode_exception => "OrganizationNotInAllFeaturesModeException",
                .password_policy_violation_exception => "PasswordPolicyViolationException",
                .policy_evaluation_exception => "PolicyEvaluationException",
                .policy_not_attachable_exception => "PolicyNotAttachableException",
                .report_generation_limit_exceeded_exception => "ReportGenerationLimitExceededException",
                .role_modified_exception => "RoleModifiedException",
                .role_template_disabled_exception => "RoleTemplateDisabledException",
                .service_access_not_enabled_exception => "ServiceAccessNotEnabledException",
                .service_failure_exception => "ServiceFailureException",
                .service_not_supported_exception => "ServiceNotSupportedException",
                .unmodifiable_entity_exception => "UnmodifiableEntityException",
                .unrecognized_public_key_encoding_exception => "UnrecognizedPublicKeyEncodingException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .account_not_management_or_delegated_administrator_exception => |e| e.message,
                .caller_is_not_management_account_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .credential_report_expired_exception => |e| e.message,
                .credential_report_not_present_exception => |e| e.message,
                .credential_report_not_ready_exception => |e| e.message,
                .delete_conflict_exception => |e| e.message,
                .duplicate_certificate_exception => |e| e.message,
                .duplicate_ssh_public_key_exception => |e| e.message,
                .entity_already_exists_exception => |e| e.message,
                .entity_temporarily_unmodifiable_exception => |e| e.message,
                .feature_disabled_exception => |e| e.message,
                .feature_enabled_exception => |e| e.message,
                .invalid_authentication_code_exception => |e| e.message,
                .invalid_certificate_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .invalid_public_key_exception => |e| e.message,
                .invalid_user_type_exception => |e| e.message,
                .key_pair_mismatch_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .malformed_certificate_exception => |e| e.message,
                .malformed_policy_document_exception => |e| e.message,
                .name_conflict_exception => |e| e.message,
                .no_such_entity_exception => |e| e.message,
                .open_id_idp_communication_error_exception => |e| e.message,
                .organization_not_found_exception => |e| e.message,
                .organization_not_in_all_features_mode_exception => |e| e.message,
                .password_policy_violation_exception => |e| e.message,
                .policy_evaluation_exception => |e| e.message,
                .policy_not_attachable_exception => |e| e.message,
                .report_generation_limit_exceeded_exception => |e| e.message,
                .role_modified_exception => |e| e.message,
                .role_template_disabled_exception => |e| e.message,
                .service_access_not_enabled_exception => |e| e.message,
                .service_failure_exception => |e| e.message,
                .service_not_supported_exception => |e| e.message,
                .unmodifiable_entity_exception => |e| e.message,
                .unrecognized_public_key_encoding_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .account_not_management_or_delegated_administrator_exception => 400,
                .caller_is_not_management_account_exception => 400,
                .concurrent_modification_exception => 409,
                .credential_report_expired_exception => 410,
                .credential_report_not_present_exception => 410,
                .credential_report_not_ready_exception => 404,
                .delete_conflict_exception => 409,
                .duplicate_certificate_exception => 409,
                .duplicate_ssh_public_key_exception => 400,
                .entity_already_exists_exception => 409,
                .entity_temporarily_unmodifiable_exception => 409,
                .feature_disabled_exception => 404,
                .feature_enabled_exception => 409,
                .invalid_authentication_code_exception => 403,
                .invalid_certificate_exception => 400,
                .invalid_input_exception => 400,
                .invalid_public_key_exception => 400,
                .invalid_user_type_exception => 400,
                .key_pair_mismatch_exception => 400,
                .limit_exceeded_exception => 409,
                .malformed_certificate_exception => 400,
                .malformed_policy_document_exception => 400,
                .name_conflict_exception => 409,
                .no_such_entity_exception => 404,
                .open_id_idp_communication_error_exception => 400,
                .organization_not_found_exception => 400,
                .organization_not_in_all_features_mode_exception => 400,
                .password_policy_violation_exception => 400,
                .policy_evaluation_exception => 500,
                .policy_not_attachable_exception => 400,
                .report_generation_limit_exceeded_exception => 409,
                .role_modified_exception => 409,
                .role_template_disabled_exception => 400,
                .service_access_not_enabled_exception => 400,
                .service_failure_exception => 500,
                .service_not_supported_exception => 404,
                .unmodifiable_entity_exception => 400,
                .unrecognized_public_key_encoding_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .account_not_management_or_delegated_administrator_exception => |e| e.request_id,
                .caller_is_not_management_account_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .credential_report_expired_exception => |e| e.request_id,
                .credential_report_not_present_exception => |e| e.request_id,
                .credential_report_not_ready_exception => |e| e.request_id,
                .delete_conflict_exception => |e| e.request_id,
                .duplicate_certificate_exception => |e| e.request_id,
                .duplicate_ssh_public_key_exception => |e| e.request_id,
                .entity_already_exists_exception => |e| e.request_id,
                .entity_temporarily_unmodifiable_exception => |e| e.request_id,
                .feature_disabled_exception => |e| e.request_id,
                .feature_enabled_exception => |e| e.request_id,
                .invalid_authentication_code_exception => |e| e.request_id,
                .invalid_certificate_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .invalid_public_key_exception => |e| e.request_id,
                .invalid_user_type_exception => |e| e.request_id,
                .key_pair_mismatch_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .malformed_certificate_exception => |e| e.request_id,
                .malformed_policy_document_exception => |e| e.request_id,
                .name_conflict_exception => |e| e.request_id,
                .no_such_entity_exception => |e| e.request_id,
                .open_id_idp_communication_error_exception => |e| e.request_id,
                .organization_not_found_exception => |e| e.request_id,
                .organization_not_in_all_features_mode_exception => |e| e.request_id,
                .password_policy_violation_exception => |e| e.request_id,
                .policy_evaluation_exception => |e| e.request_id,
                .policy_not_attachable_exception => |e| e.request_id,
                .report_generation_limit_exceeded_exception => |e| e.request_id,
                .role_modified_exception => |e| e.request_id,
                .role_template_disabled_exception => |e| e.request_id,
                .service_access_not_enabled_exception => |e| e.request_id,
                .service_failure_exception => |e| e.request_id,
                .service_not_supported_exception => |e| e.request_id,
                .unmodifiable_entity_exception => |e| e.request_id,
                .unrecognized_public_key_encoding_exception => |e| e.request_id,
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

pub const AccountNotManagementOrDelegatedAdministratorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CallerIsNotManagementAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CredentialReportExpiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CredentialReportNotPresentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CredentialReportNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateCertificateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateSSHPublicKeyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityTemporarilyUnmodifiableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FeatureDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FeatureEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAuthenticationCodeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCertificateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPublicKeyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidUserTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KeyPairMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedCertificateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NameConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OpenIdIdpCommunicationErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationNotInAllFeaturesModeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PasswordPolicyViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyEvaluationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyNotAttachableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReportGenerationLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RoleModifiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RoleTemplateDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceAccessNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnmodifiableEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnrecognizedPublicKeyEncodingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccountNotManagementOrDelegatedAdministratorException")) {
        return .{ .arena = arena, .kind = .{ .account_not_management_or_delegated_administrator_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CallerIsNotManagementAccountException")) {
        return .{ .arena = arena, .kind = .{ .caller_is_not_management_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CredentialReportExpiredException")) {
        return .{ .arena = arena, .kind = .{ .credential_report_expired_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CredentialReportNotPresentException")) {
        return .{ .arena = arena, .kind = .{ .credential_report_not_present_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CredentialReportNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .credential_report_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteConflictException")) {
        return .{ .arena = arena, .kind = .{ .delete_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateCertificateException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_certificate_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateSSHPublicKeyException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_ssh_public_key_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .entity_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityTemporarilyUnmodifiableException")) {
        return .{ .arena = arena, .kind = .{ .entity_temporarily_unmodifiable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FeatureDisabledException")) {
        return .{ .arena = arena, .kind = .{ .feature_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FeatureEnabledException")) {
        return .{ .arena = arena, .kind = .{ .feature_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthenticationCodeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_authentication_code_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_certificate_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPublicKeyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_public_key_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUserTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_user_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeyPairMismatchException")) {
        return .{ .arena = arena, .kind = .{ .key_pair_mismatch_exception = .{
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
    if (std.mem.eql(u8, error_code, "MalformedCertificateException")) {
        return .{ .arena = arena, .kind = .{ .malformed_certificate_exception = .{
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
    if (std.mem.eql(u8, error_code, "NameConflictException")) {
        return .{ .arena = arena, .kind = .{ .name_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchEntityException")) {
        return .{ .arena = arena, .kind = .{ .no_such_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpenIdIdpCommunicationErrorException")) {
        return .{ .arena = arena, .kind = .{ .open_id_idp_communication_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .organization_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotInAllFeaturesModeException")) {
        return .{ .arena = arena, .kind = .{ .organization_not_in_all_features_mode_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PasswordPolicyViolationException")) {
        return .{ .arena = arena, .kind = .{ .password_policy_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyEvaluationException")) {
        return .{ .arena = arena, .kind = .{ .policy_evaluation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotAttachableException")) {
        return .{ .arena = arena, .kind = .{ .policy_not_attachable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReportGenerationLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .report_generation_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RoleModifiedException")) {
        return .{ .arena = arena, .kind = .{ .role_modified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RoleTemplateDisabledException")) {
        return .{ .arena = arena, .kind = .{ .role_template_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceAccessNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .service_access_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .service_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnmodifiableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unmodifiable_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnrecognizedPublicKeyEncodingException")) {
        return .{ .arena = arena, .kind = .{ .unrecognized_public_key_encoding_exception = .{
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
