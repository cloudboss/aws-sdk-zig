const std = @import("std");

const AccessDeniedForDependencyExceptionReason = @import("access_denied_for_dependency_exception_reason.zig").AccessDeniedForDependencyExceptionReason;
const ConstraintViolationExceptionReason = @import("constraint_violation_exception_reason.zig").ConstraintViolationExceptionReason;
const HandshakeConstraintViolationExceptionReason = @import("handshake_constraint_violation_exception_reason.zig").HandshakeConstraintViolationExceptionReason;
const InvalidInputExceptionReason = @import("invalid_input_exception_reason.zig").InvalidInputExceptionReason;

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

/// You don't have permissions to perform the requested operation. The user or
/// role that
/// is making the request must have at least one IAM permissions policy attached
/// that
/// grants the required permissions. For more information, see [Access
/// Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/access.html) in
/// the
/// *IAM User Guide*.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation that you attempted requires you to have the
/// `iam:CreateServiceLinkedRole` for
/// `organizations.amazonaws.com` permission so that Organizations can create
/// the
/// required service-linked role. You don't have that permission.
pub const AccessDeniedForDependencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    reason: ?AccessDeniedForDependencyExceptionReason = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// You attempted to close an account that is already closed.
pub const AccountAlreadyClosedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified account is already a delegated administrator for this Amazon
/// Web Services
/// service.
pub const AccountAlreadyRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find an Amazon Web Services account with the `AccountId` that you
/// specified, or
/// the account whose credentials you used to make this request isn't a member
/// of an
/// organization.
pub const AccountNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified account is not a delegated administrator for this Amazon Web
/// Services service.
pub const AccountNotRegisteredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can't invite an existing account to your organization until you verify
/// that you
/// own the email address associated with the management account. For more
/// information, see
/// [Email address
/// verification](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_create.html#about-email-verification) in the *Organizations User Guide*.
pub const AccountOwnerNotVerifiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This account is already a member of an organization. An account can belong
/// to only one
/// organization at a time.
pub const AlreadyInOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Your account isn't a member of an organization. To make this request, you
/// must use the
/// credentials of an account that belongs to an organization.
pub const AWSOrganizationsNotInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find an organizational unit (OU) or Amazon Web Services account
/// with the
/// `ChildId` that you specified.
pub const ChildNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The target of the operation is currently being modified by a different
/// request. Try
/// again later.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed because it conflicts with the current state of the
/// specified
/// resource.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Performing this operation violates a minimum or maximum value limit. For
/// example,
/// attempting to remove the last service control policy (SCP) from an OU or
/// root, inviting
/// or creating too many accounts to the organization, or attaching too many
/// policies to an
/// account, OU, or root. This exception includes a reason that contains
/// additional
/// information about the violated limit:
///
/// Some of the reasons in the following list might not be applicable to this
/// specific
/// API or operation.
///
/// * ACCOUNT_CANNOT_LEAVE_ORGANIZATION: You attempted to remove the management
/// account from the organization. You can't remove the management account.
/// Instead,
/// after you remove all member accounts, delete the organization itself.
///
/// * ACCOUNT_CANNOT_LEAVE_WITHOUT_PHONE_VERIFICATION: You attempted to remove
///   an
/// account from the organization that doesn't yet have enough information to
/// exist
/// as a standalone account. This account requires you to first complete phone
/// verification. Follow the steps at [Removing a member account from your
/// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_remove.html#orgs_manage_accounts_remove-from-master) in the
/// *Organizations User Guide*.
///
/// * ACCOUNT_CREATION_RATE_LIMIT_EXCEEDED: You attempted to exceed the number
///   of
/// accounts that you can create in one day.
///
/// * ACCOUNT_CREATION_NOT_COMPLETE: Your account setup isn't complete or your
/// account isn't fully active. You must complete the account setup before you
/// create an organization.
///
/// * ACTIVE_RESPONSIBILITY_TRANSFER_PROCESS: You cannot delete organization due
///   to an ongoing responsibility transfer process. For example, a pending
///   invitation or an in-progress transfer. To delete the organization, you
///   must resolve the current transfer process.
///
/// * ACCOUNT_NUMBER_LIMIT_EXCEEDED: You attempted to exceed the limit on the
///   number
/// of accounts in an organization. If you need more accounts, contact [Amazon
/// Web Services Support](https://console.aws.amazon.com/support/home#/) to
/// request an increase in your limit.
///
/// Or the number of invitations that you tried to send would cause you to
/// exceed
/// the limit of accounts in your organization. Send fewer invitations or
/// contact
/// Amazon Web Services Support to request an increase in the number of
/// accounts.
///
/// Deleted and closed accounts still count toward your limit.
///
/// If you get this exception when running a command immediately after
/// creating the organization, wait one hour and try again. After an hour, if
/// the command continues to fail with this error, contact [Amazon Web Services
/// Support](https://console.aws.amazon.com/support/home#/).
///
/// * ALL_FEATURES_MIGRATION_ORGANIZATION_SIZE_LIMIT_EXCEEDED: Your organization
///   has
/// more than 5000 accounts, and you can only use the standard migration process
/// for
/// organizations with less than 5000 accounts. Use the assisted migration
/// process
/// to enable all features mode, or create a support case for assistance if you
/// are
/// unable to use assisted migration.
///
/// * CANNOT_REGISTER_SUSPENDED_ACCOUNT_AS_DELEGATED_ADMINISTRATOR: You cannot
/// register a suspended account as a delegated administrator.
///
/// * CANNOT_REGISTER_MASTER_AS_DELEGATED_ADMINISTRATOR: You attempted to
///   register
/// the management account of the organization as a delegated administrator for
/// an
/// Amazon Web Services service integrated with Organizations. You can designate
/// only a member account as a
/// delegated administrator.
///
/// * CANNOT_CLOSE_MANAGEMENT_ACCOUNT: You attempted to close the management
/// account. To close the management account for the organization, you must
/// first
/// either remove or close all member accounts in the organization. Follow
/// standard
/// account closure process using root credentials.​
///
/// * CANNOT_REMOVE_DELEGATED_ADMINISTRATOR_FROM_ORG: You attempted to remove an
/// account that is registered as a delegated administrator for a service
/// integrated
/// with your organization. To complete this operation, you must first
/// deregister
/// this account as a delegated administrator.
///
/// * CLOSE_ACCOUNT_QUOTA_EXCEEDED: You have exceeded close account quota for
///   the
/// past 30 days.
///
/// * CLOSE_ACCOUNT_REQUESTS_LIMIT_EXCEEDED: You attempted to exceed the number
///   of
/// accounts that you can close at a time. ​
///
/// * CREATE_ORGANIZATION_IN_BILLING_MODE_UNSUPPORTED_REGION: To create an
/// organization in the specified region, you must enable all features mode.
///
/// * DELEGATED_ADMINISTRATOR_EXISTS_FOR_THIS_SERVICE: You attempted to register
///   an
/// Amazon Web Services account as a delegated administrator for an Amazon Web
/// Services service that already has
/// a delegated administrator. To complete this operation, you must first
/// deregister
/// any existing delegated administrators for this service.
///
/// * EMAIL_VERIFICATION_CODE_EXPIRED: The email verification code is only valid
///   for
/// a limited period of time. You must resubmit the request and generate a new
/// verification code.
///
/// * HANDSHAKE_RATE_LIMIT_EXCEEDED: You attempted to exceed the number of
/// handshakes that you can send in one day.
///
/// * INVALID_PAYMENT_INSTRUMENT: You cannot remove an account because no
///   supported
/// payment method is associated with the account. Amazon Web Services does not
/// support cards
/// issued by financial institutions in Russia or Belarus. For more information,
/// see
/// [Managing your
/// Amazon Web Services
/// payments](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/manage-general.html).
///
/// * MASTER_ACCOUNT_ADDRESS_DOES_NOT_MATCH_MARKETPLACE: To create an account in
/// this organization, you first must migrate the organization's management
/// account
/// to the marketplace that corresponds to the management account's address. All
/// accounts in an organization must be associated with the same marketplace.
///
/// * MASTER_ACCOUNT_MISSING_BUSINESS_LICENSE: Applies only to the Amazon Web
///   Services Regions in
/// China. To create an organization, the master must have a valid business
/// license.
/// For more information, contact customer support.
///
/// * MASTER_ACCOUNT_MISSING_CONTACT_INFO: To complete this operation, you must
/// first provide a valid contact address and phone number for the management
/// account. Then try the operation again.
///
/// * MASTER_ACCOUNT_NOT_GOVCLOUD_ENABLED: To complete this operation, the
/// management account must have an associated account in the Amazon Web
/// Services GovCloud
/// (US-West) Region. For more information, see
/// [Organizations](https://docs.aws.amazon.com/govcloud-us/latest/UserGuide/govcloud-organizations.html)
/// in the
/// *Amazon Web Services GovCloud User Guide*.
///
/// * MASTER_ACCOUNT_PAYMENT_INSTRUMENT_REQUIRED: To create an organization with
/// this management account, you first must associate a valid payment
/// instrument,
/// such as a credit card, with the account. For more information, see
/// [Considerations before removing an account from an
/// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_account-before-remove.html) in
/// the *Organizations User Guide*.
///
/// * MAX_DELEGATED_ADMINISTRATORS_FOR_SERVICE_LIMIT_EXCEEDED: You attempted to
/// register more delegated administrators than allowed for the service
/// principal.
///
/// * MAX_POLICY_TYPE_ATTACHMENT_LIMIT_EXCEEDED: You attempted to exceed the
///   number
/// of policies of a certain type that can be attached to an entity at one
/// time.
///
/// * MAX_TAG_LIMIT_EXCEEDED: You have exceeded the number of tags allowed on
///   this
/// resource.
///
/// * MEMBER_ACCOUNT_PAYMENT_INSTRUMENT_REQUIRED: To complete this operation
///   with
/// this member account, you first must associate a valid payment instrument,
/// such
/// as a credit card, with the account. For more information, see
/// [Considerations before removing an account from an
/// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_account-before-remove.html) in
/// the *Organizations User Guide*.
///
/// * MIN_POLICY_TYPE_ATTACHMENT_LIMIT_EXCEEDED: You attempted to detach a
///   policy
/// from an entity that would cause the entity to have fewer than the minimum
/// number
/// of policies of a certain type required.
///
/// * ORGANIZATION_NOT_IN_ALL_FEATURES_MODE: You attempted to perform an
///   operation
/// that requires the organization to be configured to support all features. An
/// organization that supports only consolidated billing features can't perform
/// this
/// operation.
///
/// * OU_DEPTH_LIMIT_EXCEEDED: You attempted to create an OU tree that is too
///   many
/// levels deep.
///
/// * OU_NUMBER_LIMIT_EXCEEDED: You attempted to exceed the number of OUs that
///   you
/// can have in an organization.
///
/// * POLICY_CONTENT_LIMIT_EXCEEDED: You attempted to create a policy that is
///   larger
/// than the maximum size.
///
/// * POLICY_NUMBER_LIMIT_EXCEEDED: You attempted to exceed the number of
///   policies
/// that you can have in an organization.
///
/// * POLICY_TYPE_ENABLED_FOR_THIS_SERVICE: You attempted to disable service
///   access
/// before you disabled the policy type (for example, SECURITYHUB_POLICY). To
/// complete this operation, you must first disable the policy type.
///
/// * RESPONSIBILITY_TRANSFER_MAX_INBOUND_QUOTA_VIOLATION: You have exceeded
///   your inbound
/// transfers limit.
///
/// * RESPONSIBILITY_TRANSFER_MAX_LEVEL_VIOLATION: You have exceeded the maximum
///   length of your
/// transfer chain.
///
/// * RESPONSIBILITY_TRANSFER_MAX_OUTBOUND_QUOTA_VIOLATION: You have exceeded
///   your outbound
/// transfers limit.
///
/// * RESPONSIBILITY_TRANSFER_MAX_TRANSFERS_QUOTA_VIOLATION: You have exceeded
///   the maximum
/// number of inbound transfers allowed in a transfer chain.
///
/// * SERVICE_ACCESS_NOT_ENABLED:
///
/// * You attempted to register a delegated administrator before you enabled
/// service access. Call the `EnableAWSServiceAccess` API
/// first.
///
/// * You attempted to enable a policy type before you enabled service
/// access. Call the `EnableAWSServiceAccess` API first.
///
/// * TAG_POLICY_VIOLATION: You attempted to create or update a resource with
///   tags
/// that are not compliant with the tag policy requirements for this account.
///
/// * TRANSFER_RESPONSIBILITY_SOURCE_DELETION_IN_PROGRESS: The source
///   organization cannot accept
/// this transfer invitation because it is marked for deletion.
///
/// * TRANSFER_RESPONSIBILITY_TARGET_DELETION_IN_PROGRESS: The source
///   organization cannot accept
/// this transfer invitation because target organization is marked for deletion.
///
/// * UNSUPPORTED_PRICING: Your organization has a pricing contract that is
///   unsupported.
///
/// * WAIT_PERIOD_ACTIVE: After you create an Amazon Web Services account, you
///   must wait until at
/// least four days after the account was created. Invited accounts aren't
/// subject
/// to this waiting period.
pub const ConstraintViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    reason: ?ConstraintViolationExceptionReason = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// We can't find an create account request with the `CreateAccountRequestId`
/// that you specified.
pub const CreateAccountStatusNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find the destination container (a root or OU) with the `ParentId`
/// that you specified.
pub const DestinationParentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// That account is already present in the specified destination.
pub const DuplicateAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A handshake with the same action and target already exists. For example, if
/// you
/// invited an account to join your organization, the invited account might
/// already have a
/// pending invitation from this organization. If you intend to resend an
/// invitation to an
/// account, ensure that existing handshakes that might be considered duplicates
/// are
/// canceled or declined.
pub const DuplicateHandshakeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An OU with the same name already exists.
pub const DuplicateOrganizationalUnitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The selected policy is already attached to the specified target.
pub const DuplicatePolicyAttachmentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A policy with the same name already exists.
pub const DuplicatePolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// If you ran this action on the management account, this policy type is not
/// enabled. If
/// you ran the action on a member account, the account doesn't have an
/// effective policy of
/// this type. Contact the administrator of your organization about attaching a
/// policy of
/// this type to the account.
pub const EffectivePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Organizations couldn't perform the operation because your organization
/// hasn't finished
/// initializing. This can take up to an hour. Try again later. If after one
/// hour you
/// continue to receive this error, contact [Amazon Web Services
/// Support](https://console.aws.amazon.com/support/home#/).
pub const FinalizingOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified handshake is already in the requested state. For example, you
/// can't
/// accept a handshake that was already accepted.
pub const HandshakeAlreadyInStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested operation would violate the constraint identified in the
/// reason
/// code.
///
/// Some of the reasons in the following list might not be applicable to this
/// specific
/// API or operation:
///
/// * ACCOUNT_NUMBER_LIMIT_EXCEEDED: You attempted to exceed the limit on the
///   number
/// of accounts in an organization. Note that deleted and closed accounts still
/// count toward your limit.
///
/// If you get this exception immediately after creating the organization,
/// wait one hour and try again. If after an hour it continues to fail with this
/// error, contact [Amazon Web Services
/// Support](https://console.aws.amazon.com/support/home#/).
///
/// * ALREADY_IN_AN_ORGANIZATION: The handshake request is invalid because the
/// invited account is already a member of an organization.
///
/// * HANDSHAKE_RATE_LIMIT_EXCEEDED: You attempted to exceed the number of
/// handshakes that you can send in one day.
///
/// * INVITE_DISABLED_DURING_ENABLE_ALL_FEATURES: You can't issue new
///   invitations to
/// join an organization while it's in the process of enabling all features. You
/// can
/// resume inviting accounts after you finalize the process when all accounts
/// have
/// agreed to the change.
///
/// * LEGACY_PERMISSIONS_STILL_IN_USE: Your organization must migrate to use the
///   new IAM
/// fine-grained actions for billing, cost management, and accounts.
///
/// * ORGANIZATION_ALREADY_HAS_ALL_FEATURES: The handshake request is invalid
/// because the organization has already enabled all features.
///
/// * ORGANIZATION_FROM_DIFFERENT_SELLER_OF_RECORD: The request failed because
///   the
/// account is from a different marketplace than the accounts in the
/// organization.
///
/// * ORGANIZATION_IS_ALREADY_PENDING_ALL_FEATURES_MIGRATION: The handshake
///   request
/// is invalid because the organization has already started the process to
/// enable
/// all features.
///
/// * ORGANIZATION_MEMBERSHIP_CHANGE_RATE_LIMIT_EXCEEDED: You attempted to
///   change
/// the membership of an account too quickly after its previous change.
///
/// * PAYMENT_INSTRUMENT_REQUIRED: You can't complete the operation with an
///   account
/// that doesn't have a payment instrument, such as a credit card, associated
/// with
/// it.
///
/// * RESPONSIBILITY_TRANSFER_ALREADY_EXISTS: You cannot perform this operation
///   with the current
/// transfer.
///
/// * SOURCE_AND_TARGET_CANNOT_MATCH: An account can't accept a transfer
///   invitation if it is both the sender and recipient of the invitation.
///
/// * UNUSED_PREPAYMENT_BALANCE: Your organization has an outstanding
///   pre-payment balance.
pub const HandshakeConstraintViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    reason: ?HandshakeConstraintViolationExceptionReason = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// We can't find a handshake with the `HandshakeId` that you specified.
pub const HandshakeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can't perform the operation on the handshake in its current state. For
/// example,
/// you can't cancel a handshake that was already accepted or accept a handshake
/// that was
/// already declined.
pub const InvalidHandshakeTransitionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The requested operation failed because you provided invalid values for one
/// or more of
/// the request parameters. This exception includes a reason that contains
/// additional
/// information about the violated limit:
///
/// Some of the reasons in the following list might not be applicable to this
/// specific
/// API or operation.
///
/// * CALLER_REQUIRED_FIELD_MISSING: At least one of the required field is
///   missing: Caller Account Id, Management Account Id or Organization Id.
///
/// * DUPLICATE_TAG_KEY: Tag keys must be unique among the tags attached to the
///   same
/// entity.
///
/// * END_DATE_NOT_END_OF_MONTH: You provided an invalid end date. The end date
///   must be the end
/// of the last day of the month (23.59.59.999).
///
/// * END_DATE_TOO_EARLY: You provided an invalid end date. It is too early for
///   the transfer to
/// end.
///
/// * IMMUTABLE_POLICY: You specified a policy that is managed by Amazon Web
///   Services and can't be
/// modified.
///
/// * INPUT_REQUIRED: You must include a value for all required parameters.
///
/// * INVALID_EMAIL_ADDRESS_TARGET: You specified an invalid email address for
///   the
/// invited account owner.
///
/// * INVALID_END_DATE: The selected withdrawal date doesn't meet the terms of
///   your partner
/// agreement. Visit Amazon Web Services Partner Central to view your partner
/// agreements or contact your Amazon Web Services
/// Partner for help.
///
/// * INVALID_ENUM: You specified an invalid value.
///
/// * INVALID_ENUM_POLICY_TYPE: You specified an invalid policy type string.
///
/// * INVALID_FULL_NAME_TARGET: You specified a full name that contains invalid
/// characters.
///
/// * INVALID_LIST_MEMBER: You provided a list to a parameter that contains at
///   least
/// one invalid value.
///
/// * INVALID_PAGINATION_TOKEN: Get the value for the `NextToken`
/// parameter from the response to a previous call of the operation.
///
/// * INVALID_PARTY_TYPE_TARGET: You specified the wrong type of entity
///   (account,
/// organization, or email) as a party.
///
/// * INVALID_PATTERN: You provided a value that doesn't match the required
/// pattern.
///
/// * INVALID_PATTERN_TARGET_ID: You specified a policy target ID that doesn't
///   match
/// the required pattern.
///
/// * INVALID_PRINCIPAL: You specified an invalid principal element in the
/// policy.
///
/// * INVALID_ROLE_NAME: You provided a role name that isn't valid. A role name
/// can't begin with the reserved prefix `AWSServiceRoleFor`.
///
/// * INVALID_START_DATE: The start date doesn't meet the minimum requirements.
///
/// * INVALID_SYNTAX_ORGANIZATION_ARN: You specified an invalid Amazon Resource
///   Name
/// (ARN) for the organization.
///
/// * INVALID_SYNTAX_POLICY_ID: You specified an invalid policy ID.
///
/// * INVALID_SYSTEM_TAGS_PARAMETER: You specified a tag key that is a system
///   tag.
/// You can’t add, edit, or delete system tag keys because they're reserved for
/// Amazon Web Services use. System tags don’t count against your tags per
/// resource limit.
///
/// * MAX_FILTER_LIMIT_EXCEEDED: You can specify only one filter parameter for
///   the
/// operation.
///
/// * MAX_LENGTH_EXCEEDED: You provided a string parameter that is longer than
/// allowed.
///
/// * MAX_VALUE_EXCEEDED: You provided a numeric parameter that has a larger
///   value
/// than allowed.
///
/// * MIN_LENGTH_EXCEEDED: You provided a string parameter that is shorter than
/// allowed.
///
/// * MIN_VALUE_EXCEEDED: You provided a numeric parameter that has a smaller
///   value
/// than allowed.
///
/// * MOVING_ACCOUNT_BETWEEN_DIFFERENT_ROOTS: You can move an account only
///   between
/// entities in the same root.
///
/// * NON_DETACHABLE_POLICY: You can't detach this Amazon Web Services Managed
///   Policy.
///
/// * START_DATE_NOT_BEGINNING_OF_DAY: You provided an invalid start date. The
///   start date must
/// be the beginning of the day (00:00:00.000).
///
/// * START_DATE_NOT_BEGINNING_OF_MONTH: You provided an invalid start date. The
///   start date must
/// be the first day of the month.
///
/// * START_DATE_TOO_EARLY: You provided an invalid start date. The start date
///   is too early.
///
/// * START_DATE_TOO_LATE: You provided an invalid start date. The start date is
///   too late.
///
/// * TARGET_NOT_SUPPORTED: You can't perform the specified operation on that
///   target
/// entity.
///
/// * UNRECOGNIZED_SERVICE_PRINCIPAL: You specified a service principal that
///   isn't
/// recognized.
///
/// * UNSUPPORTED_ACTION_IN_RESPONSIBILITY_TRANSFER: You provided a value that
///   is not supported
/// by this operation.
pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    reason: ?InvalidInputExceptionReason = null,

    pub const json_field_names = .{
        .message = "Message",
        .reason = "Reason",
    };
};

/// The responsibility transfer can't transition to the requested state because
/// it's not
/// in a valid state for this operation.
pub const InvalidResponsibilityTransferTransitionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The provided policy document doesn't meet the requirements of the specified
/// policy
/// type. For example, the syntax might be incorrect. For details about service
/// control
/// policy syntax, see [SCP
/// syntax](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_syntax.html) in the
/// *Organizations User Guide*.
pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can't remove a management account from an organization. If you want the
/// management
/// account to become a member account in another organization, you must first
/// delete the
/// current organization of the management account.
pub const MasterCannotLeaveOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The organization isn't empty. To delete an organization, you must first
/// remove all
/// accounts except the management account.
pub const OrganizationNotEmptyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified OU is not empty. Move all accounts to another root or to other
/// OUs,
/// remove all child OUs, and try the operation again.
pub const OrganizationalUnitNotEmptyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find an OU with the `OrganizationalUnitId` that you
/// specified.
pub const OrganizationalUnitNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find a root or OU with the `ParentId` that you specified.
pub const ParentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Changes to the effective policy are in progress, and its contents can't be
/// returned.
/// Try the operation again later.
pub const PolicyChangesInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The policy is attached to one or more entities. You must detach it from all
/// roots,
/// OUs, and accounts before performing this operation.
pub const PolicyInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The policy isn't attached to the specified target in the specified root.
pub const PolicyNotAttachedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find a policy with the `PolicyId` that you specified.
pub const PolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified policy type is already enabled in the specified root.
pub const PolicyTypeAlreadyEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can't use the specified policy type with the feature set currently
/// enabled for
/// this organization. For example, you can enable SCPs only after you enable
/// all features
/// in the organization. For more information, see [Managing
/// Organizations
/// policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies.html#enable_policies_on_root)in the *Organizations User Guide*.
pub const PolicyTypeNotAvailableForOrganizationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified policy type isn't currently enabled in this root. You can't
/// attach
/// policies of the specified type to entities in a root until you enable that
/// type in the
/// root. For more information, see [Enabling all features
/// in your
/// organization](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_support-all-features.html) in the *Organizations User Guide*.
pub const PolicyTypeNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find a resource policy request with the parameter that you
/// specified.
pub const ResourcePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The responsibility transfer is already in the status that you specified.
pub const ResponsibilityTransferAlreadyInStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find a transfer that you specified.
pub const ResponsibilityTransferNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find a root with the `RootId` that you specified.
pub const RootNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Organizations can't complete your request because of an internal service
/// error. Try again
/// later.
pub const ServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find a source root or OU with the `ParentId` that you
/// specified.
pub const SourceParentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can't find a root, OU, account, or policy with the `TargetId` that you
/// specified.
pub const TargetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You have sent too many requests in too short a period of time. The quota
/// helps protect
/// against denial-of-service attacks. Try again later.
///
/// For information about quotas that affect Organizations, see [Quotas for
/// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_limits.html) in the
/// *Organizations User Guide*.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
    };
};

/// This action isn't available in the current Amazon Web Services Region.
pub const UnsupportedAPIEndpointException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
