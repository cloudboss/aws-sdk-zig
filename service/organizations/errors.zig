const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        access_denied_for_dependency_exception: AccessDeniedForDependencyException,
        account_already_closed_exception: AccountAlreadyClosedException,
        account_already_registered_exception: AccountAlreadyRegisteredException,
        account_not_found_exception: AccountNotFoundException,
        account_not_registered_exception: AccountNotRegisteredException,
        account_owner_not_verified_exception: AccountOwnerNotVerifiedException,
        already_in_organization_exception: AlreadyInOrganizationException,
        aws_organizations_not_in_use_exception: AWSOrganizationsNotInUseException,
        child_not_found_exception: ChildNotFoundException,
        concurrent_modification_exception: ConcurrentModificationException,
        conflict_exception: ConflictException,
        constraint_violation_exception: ConstraintViolationException,
        create_account_status_not_found_exception: CreateAccountStatusNotFoundException,
        destination_parent_not_found_exception: DestinationParentNotFoundException,
        duplicate_account_exception: DuplicateAccountException,
        duplicate_handshake_exception: DuplicateHandshakeException,
        duplicate_organizational_unit_exception: DuplicateOrganizationalUnitException,
        duplicate_policy_attachment_exception: DuplicatePolicyAttachmentException,
        duplicate_policy_exception: DuplicatePolicyException,
        effective_policy_not_found_exception: EffectivePolicyNotFoundException,
        finalizing_organization_exception: FinalizingOrganizationException,
        handshake_already_in_state_exception: HandshakeAlreadyInStateException,
        handshake_constraint_violation_exception: HandshakeConstraintViolationException,
        handshake_not_found_exception: HandshakeNotFoundException,
        invalid_handshake_transition_exception: InvalidHandshakeTransitionException,
        invalid_input_exception: InvalidInputException,
        invalid_responsibility_transfer_transition_exception: InvalidResponsibilityTransferTransitionException,
        malformed_policy_document_exception: MalformedPolicyDocumentException,
        master_cannot_leave_organization_exception: MasterCannotLeaveOrganizationException,
        organization_not_empty_exception: OrganizationNotEmptyException,
        organizational_unit_not_empty_exception: OrganizationalUnitNotEmptyException,
        organizational_unit_not_found_exception: OrganizationalUnitNotFoundException,
        parent_not_found_exception: ParentNotFoundException,
        policy_changes_in_progress_exception: PolicyChangesInProgressException,
        policy_in_use_exception: PolicyInUseException,
        policy_not_attached_exception: PolicyNotAttachedException,
        policy_not_found_exception: PolicyNotFoundException,
        policy_type_already_enabled_exception: PolicyTypeAlreadyEnabledException,
        policy_type_not_available_for_organization_exception: PolicyTypeNotAvailableForOrganizationException,
        policy_type_not_enabled_exception: PolicyTypeNotEnabledException,
        resource_policy_not_found_exception: ResourcePolicyNotFoundException,
        responsibility_transfer_already_in_status_exception: ResponsibilityTransferAlreadyInStatusException,
        responsibility_transfer_not_found_exception: ResponsibilityTransferNotFoundException,
        root_not_found_exception: RootNotFoundException,
        service_exception: ServiceException,
        source_parent_not_found_exception: SourceParentNotFoundException,
        target_not_found_exception: TargetNotFoundException,
        too_many_requests_exception: TooManyRequestsException,
        unsupported_api_endpoint_exception: UnsupportedAPIEndpointException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .access_denied_for_dependency_exception => "AccessDeniedForDependencyException",
                .account_already_closed_exception => "AccountAlreadyClosedException",
                .account_already_registered_exception => "AccountAlreadyRegisteredException",
                .account_not_found_exception => "AccountNotFoundException",
                .account_not_registered_exception => "AccountNotRegisteredException",
                .account_owner_not_verified_exception => "AccountOwnerNotVerifiedException",
                .already_in_organization_exception => "AlreadyInOrganizationException",
                .aws_organizations_not_in_use_exception => "AWSOrganizationsNotInUseException",
                .child_not_found_exception => "ChildNotFoundException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .conflict_exception => "ConflictException",
                .constraint_violation_exception => "ConstraintViolationException",
                .create_account_status_not_found_exception => "CreateAccountStatusNotFoundException",
                .destination_parent_not_found_exception => "DestinationParentNotFoundException",
                .duplicate_account_exception => "DuplicateAccountException",
                .duplicate_handshake_exception => "DuplicateHandshakeException",
                .duplicate_organizational_unit_exception => "DuplicateOrganizationalUnitException",
                .duplicate_policy_attachment_exception => "DuplicatePolicyAttachmentException",
                .duplicate_policy_exception => "DuplicatePolicyException",
                .effective_policy_not_found_exception => "EffectivePolicyNotFoundException",
                .finalizing_organization_exception => "FinalizingOrganizationException",
                .handshake_already_in_state_exception => "HandshakeAlreadyInStateException",
                .handshake_constraint_violation_exception => "HandshakeConstraintViolationException",
                .handshake_not_found_exception => "HandshakeNotFoundException",
                .invalid_handshake_transition_exception => "InvalidHandshakeTransitionException",
                .invalid_input_exception => "InvalidInputException",
                .invalid_responsibility_transfer_transition_exception => "InvalidResponsibilityTransferTransitionException",
                .malformed_policy_document_exception => "MalformedPolicyDocumentException",
                .master_cannot_leave_organization_exception => "MasterCannotLeaveOrganizationException",
                .organization_not_empty_exception => "OrganizationNotEmptyException",
                .organizational_unit_not_empty_exception => "OrganizationalUnitNotEmptyException",
                .organizational_unit_not_found_exception => "OrganizationalUnitNotFoundException",
                .parent_not_found_exception => "ParentNotFoundException",
                .policy_changes_in_progress_exception => "PolicyChangesInProgressException",
                .policy_in_use_exception => "PolicyInUseException",
                .policy_not_attached_exception => "PolicyNotAttachedException",
                .policy_not_found_exception => "PolicyNotFoundException",
                .policy_type_already_enabled_exception => "PolicyTypeAlreadyEnabledException",
                .policy_type_not_available_for_organization_exception => "PolicyTypeNotAvailableForOrganizationException",
                .policy_type_not_enabled_exception => "PolicyTypeNotEnabledException",
                .resource_policy_not_found_exception => "ResourcePolicyNotFoundException",
                .responsibility_transfer_already_in_status_exception => "ResponsibilityTransferAlreadyInStatusException",
                .responsibility_transfer_not_found_exception => "ResponsibilityTransferNotFoundException",
                .root_not_found_exception => "RootNotFoundException",
                .service_exception => "ServiceException",
                .source_parent_not_found_exception => "SourceParentNotFoundException",
                .target_not_found_exception => "TargetNotFoundException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unsupported_api_endpoint_exception => "UnsupportedAPIEndpointException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .access_denied_for_dependency_exception => |e| e.message,
                .account_already_closed_exception => |e| e.message,
                .account_already_registered_exception => |e| e.message,
                .account_not_found_exception => |e| e.message,
                .account_not_registered_exception => |e| e.message,
                .account_owner_not_verified_exception => |e| e.message,
                .already_in_organization_exception => |e| e.message,
                .aws_organizations_not_in_use_exception => |e| e.message,
                .child_not_found_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .constraint_violation_exception => |e| e.message,
                .create_account_status_not_found_exception => |e| e.message,
                .destination_parent_not_found_exception => |e| e.message,
                .duplicate_account_exception => |e| e.message,
                .duplicate_handshake_exception => |e| e.message,
                .duplicate_organizational_unit_exception => |e| e.message,
                .duplicate_policy_attachment_exception => |e| e.message,
                .duplicate_policy_exception => |e| e.message,
                .effective_policy_not_found_exception => |e| e.message,
                .finalizing_organization_exception => |e| e.message,
                .handshake_already_in_state_exception => |e| e.message,
                .handshake_constraint_violation_exception => |e| e.message,
                .handshake_not_found_exception => |e| e.message,
                .invalid_handshake_transition_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .invalid_responsibility_transfer_transition_exception => |e| e.message,
                .malformed_policy_document_exception => |e| e.message,
                .master_cannot_leave_organization_exception => |e| e.message,
                .organization_not_empty_exception => |e| e.message,
                .organizational_unit_not_empty_exception => |e| e.message,
                .organizational_unit_not_found_exception => |e| e.message,
                .parent_not_found_exception => |e| e.message,
                .policy_changes_in_progress_exception => |e| e.message,
                .policy_in_use_exception => |e| e.message,
                .policy_not_attached_exception => |e| e.message,
                .policy_not_found_exception => |e| e.message,
                .policy_type_already_enabled_exception => |e| e.message,
                .policy_type_not_available_for_organization_exception => |e| e.message,
                .policy_type_not_enabled_exception => |e| e.message,
                .resource_policy_not_found_exception => |e| e.message,
                .responsibility_transfer_already_in_status_exception => |e| e.message,
                .responsibility_transfer_not_found_exception => |e| e.message,
                .root_not_found_exception => |e| e.message,
                .service_exception => |e| e.message,
                .source_parent_not_found_exception => |e| e.message,
                .target_not_found_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unsupported_api_endpoint_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .access_denied_for_dependency_exception => 403,
                .account_already_closed_exception => 409,
                .account_already_registered_exception => 409,
                .account_not_found_exception => 404,
                .account_not_registered_exception => 409,
                .account_owner_not_verified_exception => 403,
                .already_in_organization_exception => 409,
                .aws_organizations_not_in_use_exception => 404,
                .child_not_found_exception => 404,
                .concurrent_modification_exception => 409,
                .conflict_exception => 409,
                .constraint_violation_exception => 409,
                .create_account_status_not_found_exception => 404,
                .destination_parent_not_found_exception => 404,
                .duplicate_account_exception => 409,
                .duplicate_handshake_exception => 409,
                .duplicate_organizational_unit_exception => 409,
                .duplicate_policy_attachment_exception => 409,
                .duplicate_policy_exception => 409,
                .effective_policy_not_found_exception => 400,
                .finalizing_organization_exception => 409,
                .handshake_already_in_state_exception => 409,
                .handshake_constraint_violation_exception => 409,
                .handshake_not_found_exception => 404,
                .invalid_handshake_transition_exception => 409,
                .invalid_input_exception => 400,
                .invalid_responsibility_transfer_transition_exception => 409,
                .malformed_policy_document_exception => 400,
                .master_cannot_leave_organization_exception => 409,
                .organization_not_empty_exception => 409,
                .organizational_unit_not_empty_exception => 409,
                .organizational_unit_not_found_exception => 404,
                .parent_not_found_exception => 404,
                .policy_changes_in_progress_exception => 400,
                .policy_in_use_exception => 409,
                .policy_not_attached_exception => 409,
                .policy_not_found_exception => 404,
                .policy_type_already_enabled_exception => 409,
                .policy_type_not_available_for_organization_exception => 409,
                .policy_type_not_enabled_exception => 409,
                .resource_policy_not_found_exception => 404,
                .responsibility_transfer_already_in_status_exception => 409,
                .responsibility_transfer_not_found_exception => 404,
                .root_not_found_exception => 404,
                .service_exception => 500,
                .source_parent_not_found_exception => 404,
                .target_not_found_exception => 404,
                .too_many_requests_exception => 429,
                .unsupported_api_endpoint_exception => 403,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .access_denied_for_dependency_exception => |e| e.request_id,
                .account_already_closed_exception => |e| e.request_id,
                .account_already_registered_exception => |e| e.request_id,
                .account_not_found_exception => |e| e.request_id,
                .account_not_registered_exception => |e| e.request_id,
                .account_owner_not_verified_exception => |e| e.request_id,
                .already_in_organization_exception => |e| e.request_id,
                .aws_organizations_not_in_use_exception => |e| e.request_id,
                .child_not_found_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .constraint_violation_exception => |e| e.request_id,
                .create_account_status_not_found_exception => |e| e.request_id,
                .destination_parent_not_found_exception => |e| e.request_id,
                .duplicate_account_exception => |e| e.request_id,
                .duplicate_handshake_exception => |e| e.request_id,
                .duplicate_organizational_unit_exception => |e| e.request_id,
                .duplicate_policy_attachment_exception => |e| e.request_id,
                .duplicate_policy_exception => |e| e.request_id,
                .effective_policy_not_found_exception => |e| e.request_id,
                .finalizing_organization_exception => |e| e.request_id,
                .handshake_already_in_state_exception => |e| e.request_id,
                .handshake_constraint_violation_exception => |e| e.request_id,
                .handshake_not_found_exception => |e| e.request_id,
                .invalid_handshake_transition_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .invalid_responsibility_transfer_transition_exception => |e| e.request_id,
                .malformed_policy_document_exception => |e| e.request_id,
                .master_cannot_leave_organization_exception => |e| e.request_id,
                .organization_not_empty_exception => |e| e.request_id,
                .organizational_unit_not_empty_exception => |e| e.request_id,
                .organizational_unit_not_found_exception => |e| e.request_id,
                .parent_not_found_exception => |e| e.request_id,
                .policy_changes_in_progress_exception => |e| e.request_id,
                .policy_in_use_exception => |e| e.request_id,
                .policy_not_attached_exception => |e| e.request_id,
                .policy_not_found_exception => |e| e.request_id,
                .policy_type_already_enabled_exception => |e| e.request_id,
                .policy_type_not_available_for_organization_exception => |e| e.request_id,
                .policy_type_not_enabled_exception => |e| e.request_id,
                .resource_policy_not_found_exception => |e| e.request_id,
                .responsibility_transfer_already_in_status_exception => |e| e.request_id,
                .responsibility_transfer_not_found_exception => |e| e.request_id,
                .root_not_found_exception => |e| e.request_id,
                .service_exception => |e| e.request_id,
                .source_parent_not_found_exception => |e| e.request_id,
                .target_not_found_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .unsupported_api_endpoint_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccessDeniedForDependencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountAlreadyClosedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountNotRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountOwnerNotVerifiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AlreadyInOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AWSOrganizationsNotInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ChildNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConstraintViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CreateAccountStatusNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DestinationParentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateHandshakeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateOrganizationalUnitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicatePolicyAttachmentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicatePolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EffectivePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FinalizingOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HandshakeAlreadyInStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HandshakeConstraintViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HandshakeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidHandshakeTransitionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResponsibilityTransferTransitionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MasterCannotLeaveOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationNotEmptyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationalUnitNotEmptyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OrganizationalUnitNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ParentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyChangesInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyNotAttachedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyTypeAlreadyEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyTypeNotAvailableForOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyTypeNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourcePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResponsibilityTransferAlreadyInStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResponsibilityTransferNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RootNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SourceParentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedAPIEndpointException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
