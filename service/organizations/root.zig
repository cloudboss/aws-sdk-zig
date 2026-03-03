const PolicyTypeSummary = @import("policy_type_summary.zig").PolicyTypeSummary;

/// Contains details about a root. A root is a top-level parent node in the
/// hierarchy of
/// an organization that can contain organizational units (OUs) and accounts.
/// The root contains every Amazon Web Services account in the
/// organization.
pub const Root = struct {
    /// The Amazon Resource Name (ARN) of the root.
    ///
    /// For more information about ARNs in Organizations, see [ARN
    /// Formats Supported by
    /// Organizations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsorganizations.html#awsorganizations-resources-for-iam-policies) in the *Amazon Web Services Service Authorization Reference*.
    arn: ?[]const u8 = null,

    /// The unique identifier (ID) for the root. The ID is unique to the
    /// organization
    /// only.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a root ID string
    /// requires "r-" followed by
    /// from 4 to 32 lowercase letters or digits.
    id: ?[]const u8 = null,

    /// The friendly name of the root.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of any of the characters
    /// in the ASCII
    /// character range.
    name: ?[]const u8 = null,

    /// The types of policies that are currently enabled for the root and therefore
    /// can be
    /// attached to the root or to its OUs or accounts.
    ///
    /// Even if a policy type is shown as available in the organization, you can
    /// separately enable and disable them at the root level by using
    /// EnablePolicyType and DisablePolicyType. Use DescribeOrganization to see the
    /// availability of the policy types in
    /// that organization.
    policy_types: ?[]const PolicyTypeSummary = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
        .policy_types = "PolicyTypes",
    };
};

pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const AcceptHandshakeInput = @import("accept_handshake.zig").AcceptHandshakeInput;
pub const AcceptHandshakeOutput = @import("accept_handshake.zig").AcceptHandshakeOutput;
pub const AttachPolicyInput = @import("attach_policy.zig").AttachPolicyInput;
pub const CancelHandshakeInput = @import("cancel_handshake.zig").CancelHandshakeInput;
pub const CancelHandshakeOutput = @import("cancel_handshake.zig").CancelHandshakeOutput;
pub const CloseAccountInput = @import("close_account.zig").CloseAccountInput;
pub const CreateAccountInput = @import("create_account.zig").CreateAccountInput;
pub const CreateAccountOutput = @import("create_account.zig").CreateAccountOutput;
pub const CreateGovCloudAccountInput = @import("create_gov_cloud_account.zig").CreateGovCloudAccountInput;
pub const CreateGovCloudAccountOutput = @import("create_gov_cloud_account.zig").CreateGovCloudAccountOutput;
pub const CreateOrganizationInput = @import("create_organization.zig").CreateOrganizationInput;
pub const CreateOrganizationOutput = @import("create_organization.zig").CreateOrganizationOutput;
pub const CreateOrganizationalUnitInput = @import("create_organizational_unit.zig").CreateOrganizationalUnitInput;
pub const CreateOrganizationalUnitOutput = @import("create_organizational_unit.zig").CreateOrganizationalUnitOutput;
pub const CreatePolicyInput = @import("create_policy.zig").CreatePolicyInput;
pub const CreatePolicyOutput = @import("create_policy.zig").CreatePolicyOutput;
pub const DeclineHandshakeInput = @import("decline_handshake.zig").DeclineHandshakeInput;
pub const DeclineHandshakeOutput = @import("decline_handshake.zig").DeclineHandshakeOutput;
pub const DeleteOrganizationalUnitInput = @import("delete_organizational_unit.zig").DeleteOrganizationalUnitInput;
pub const DeletePolicyInput = @import("delete_policy.zig").DeletePolicyInput;
pub const DeregisterDelegatedAdministratorInput = @import("deregister_delegated_administrator.zig").DeregisterDelegatedAdministratorInput;
pub const DescribeAccountInput = @import("describe_account.zig").DescribeAccountInput;
pub const DescribeAccountOutput = @import("describe_account.zig").DescribeAccountOutput;
pub const DescribeCreateAccountStatusInput = @import("describe_create_account_status.zig").DescribeCreateAccountStatusInput;
pub const DescribeCreateAccountStatusOutput = @import("describe_create_account_status.zig").DescribeCreateAccountStatusOutput;
pub const DescribeEffectivePolicyInput = @import("describe_effective_policy.zig").DescribeEffectivePolicyInput;
pub const DescribeEffectivePolicyOutput = @import("describe_effective_policy.zig").DescribeEffectivePolicyOutput;
pub const DescribeHandshakeInput = @import("describe_handshake.zig").DescribeHandshakeInput;
pub const DescribeHandshakeOutput = @import("describe_handshake.zig").DescribeHandshakeOutput;
pub const DescribeOrganizationOutput = @import("describe_organization.zig").DescribeOrganizationOutput;
pub const DescribeOrganizationalUnitInput = @import("describe_organizational_unit.zig").DescribeOrganizationalUnitInput;
pub const DescribeOrganizationalUnitOutput = @import("describe_organizational_unit.zig").DescribeOrganizationalUnitOutput;
pub const DescribePolicyInput = @import("describe_policy.zig").DescribePolicyInput;
pub const DescribePolicyOutput = @import("describe_policy.zig").DescribePolicyOutput;
pub const DescribeResourcePolicyOutput = @import("describe_resource_policy.zig").DescribeResourcePolicyOutput;
pub const DescribeResponsibilityTransferInput = @import("describe_responsibility_transfer.zig").DescribeResponsibilityTransferInput;
pub const DescribeResponsibilityTransferOutput = @import("describe_responsibility_transfer.zig").DescribeResponsibilityTransferOutput;
pub const DetachPolicyInput = @import("detach_policy.zig").DetachPolicyInput;
pub const DisableAWSServiceAccessInput = @import("disable_aws_service_access.zig").DisableAWSServiceAccessInput;
pub const DisablePolicyTypeInput = @import("disable_policy_type.zig").DisablePolicyTypeInput;
pub const DisablePolicyTypeOutput = @import("disable_policy_type.zig").DisablePolicyTypeOutput;
pub const EnableAWSServiceAccessInput = @import("enable_aws_service_access.zig").EnableAWSServiceAccessInput;
pub const EnableAllFeaturesInput = @import("enable_all_features.zig").EnableAllFeaturesInput;
pub const EnableAllFeaturesOutput = @import("enable_all_features.zig").EnableAllFeaturesOutput;
pub const EnablePolicyTypeInput = @import("enable_policy_type.zig").EnablePolicyTypeInput;
pub const EnablePolicyTypeOutput = @import("enable_policy_type.zig").EnablePolicyTypeOutput;
pub const InviteAccountToOrganizationInput = @import("invite_account_to_organization.zig").InviteAccountToOrganizationInput;
pub const InviteAccountToOrganizationOutput = @import("invite_account_to_organization.zig").InviteAccountToOrganizationOutput;
pub const InviteOrganizationToTransferResponsibilityInput = @import("invite_organization_to_transfer_responsibility.zig").InviteOrganizationToTransferResponsibilityInput;
pub const InviteOrganizationToTransferResponsibilityOutput = @import("invite_organization_to_transfer_responsibility.zig").InviteOrganizationToTransferResponsibilityOutput;
pub const ListAWSServiceAccessForOrganizationInput = @import("list_aws_service_access_for_organization.zig").ListAWSServiceAccessForOrganizationInput;
pub const ListAWSServiceAccessForOrganizationOutput = @import("list_aws_service_access_for_organization.zig").ListAWSServiceAccessForOrganizationOutput;
pub const ListAccountsForParentInput = @import("list_accounts_for_parent.zig").ListAccountsForParentInput;
pub const ListAccountsForParentOutput = @import("list_accounts_for_parent.zig").ListAccountsForParentOutput;
pub const ListAccountsInput = @import("list_accounts.zig").ListAccountsInput;
pub const ListAccountsOutput = @import("list_accounts.zig").ListAccountsOutput;
pub const ListAccountsWithInvalidEffectivePolicyInput = @import("list_accounts_with_invalid_effective_policy.zig").ListAccountsWithInvalidEffectivePolicyInput;
pub const ListAccountsWithInvalidEffectivePolicyOutput = @import("list_accounts_with_invalid_effective_policy.zig").ListAccountsWithInvalidEffectivePolicyOutput;
pub const ListChildrenInput = @import("list_children.zig").ListChildrenInput;
pub const ListChildrenOutput = @import("list_children.zig").ListChildrenOutput;
pub const ListCreateAccountStatusInput = @import("list_create_account_status.zig").ListCreateAccountStatusInput;
pub const ListCreateAccountStatusOutput = @import("list_create_account_status.zig").ListCreateAccountStatusOutput;
pub const ListDelegatedAdministratorsInput = @import("list_delegated_administrators.zig").ListDelegatedAdministratorsInput;
pub const ListDelegatedAdministratorsOutput = @import("list_delegated_administrators.zig").ListDelegatedAdministratorsOutput;
pub const ListDelegatedServicesForAccountInput = @import("list_delegated_services_for_account.zig").ListDelegatedServicesForAccountInput;
pub const ListDelegatedServicesForAccountOutput = @import("list_delegated_services_for_account.zig").ListDelegatedServicesForAccountOutput;
pub const ListEffectivePolicyValidationErrorsInput = @import("list_effective_policy_validation_errors.zig").ListEffectivePolicyValidationErrorsInput;
pub const ListEffectivePolicyValidationErrorsOutput = @import("list_effective_policy_validation_errors.zig").ListEffectivePolicyValidationErrorsOutput;
pub const ListHandshakesForAccountInput = @import("list_handshakes_for_account.zig").ListHandshakesForAccountInput;
pub const ListHandshakesForAccountOutput = @import("list_handshakes_for_account.zig").ListHandshakesForAccountOutput;
pub const ListHandshakesForOrganizationInput = @import("list_handshakes_for_organization.zig").ListHandshakesForOrganizationInput;
pub const ListHandshakesForOrganizationOutput = @import("list_handshakes_for_organization.zig").ListHandshakesForOrganizationOutput;
pub const ListInboundResponsibilityTransfersInput = @import("list_inbound_responsibility_transfers.zig").ListInboundResponsibilityTransfersInput;
pub const ListInboundResponsibilityTransfersOutput = @import("list_inbound_responsibility_transfers.zig").ListInboundResponsibilityTransfersOutput;
pub const ListOrganizationalUnitsForParentInput = @import("list_organizational_units_for_parent.zig").ListOrganizationalUnitsForParentInput;
pub const ListOrganizationalUnitsForParentOutput = @import("list_organizational_units_for_parent.zig").ListOrganizationalUnitsForParentOutput;
pub const ListOutboundResponsibilityTransfersInput = @import("list_outbound_responsibility_transfers.zig").ListOutboundResponsibilityTransfersInput;
pub const ListOutboundResponsibilityTransfersOutput = @import("list_outbound_responsibility_transfers.zig").ListOutboundResponsibilityTransfersOutput;
pub const ListParentsInput = @import("list_parents.zig").ListParentsInput;
pub const ListParentsOutput = @import("list_parents.zig").ListParentsOutput;
pub const ListPoliciesForTargetInput = @import("list_policies_for_target.zig").ListPoliciesForTargetInput;
pub const ListPoliciesForTargetOutput = @import("list_policies_for_target.zig").ListPoliciesForTargetOutput;
pub const ListPoliciesInput = @import("list_policies.zig").ListPoliciesInput;
pub const ListPoliciesOutput = @import("list_policies.zig").ListPoliciesOutput;
pub const ListRootsInput = @import("list_roots.zig").ListRootsInput;
pub const ListRootsOutput = @import("list_roots.zig").ListRootsOutput;
pub const ListTagsForResourceInput = @import("list_tags_for_resource.zig").ListTagsForResourceInput;
pub const ListTagsForResourceOutput = @import("list_tags_for_resource.zig").ListTagsForResourceOutput;
pub const ListTargetsForPolicyInput = @import("list_targets_for_policy.zig").ListTargetsForPolicyInput;
pub const ListTargetsForPolicyOutput = @import("list_targets_for_policy.zig").ListTargetsForPolicyOutput;
pub const MoveAccountInput = @import("move_account.zig").MoveAccountInput;
pub const PutResourcePolicyInput = @import("put_resource_policy.zig").PutResourcePolicyInput;
pub const PutResourcePolicyOutput = @import("put_resource_policy.zig").PutResourcePolicyOutput;
pub const RegisterDelegatedAdministratorInput = @import("register_delegated_administrator.zig").RegisterDelegatedAdministratorInput;
pub const RemoveAccountFromOrganizationInput = @import("remove_account_from_organization.zig").RemoveAccountFromOrganizationInput;
pub const TagResourceInput = @import("tag_resource.zig").TagResourceInput;
pub const TerminateResponsibilityTransferInput = @import("terminate_responsibility_transfer.zig").TerminateResponsibilityTransferInput;
pub const TerminateResponsibilityTransferOutput = @import("terminate_responsibility_transfer.zig").TerminateResponsibilityTransferOutput;
pub const UntagResourceInput = @import("untag_resource.zig").UntagResourceInput;
pub const UpdateOrganizationalUnitInput = @import("update_organizational_unit.zig").UpdateOrganizationalUnitInput;
pub const UpdateOrganizationalUnitOutput = @import("update_organizational_unit.zig").UpdateOrganizationalUnitOutput;
pub const UpdatePolicyInput = @import("update_policy.zig").UpdatePolicyInput;
pub const UpdatePolicyOutput = @import("update_policy.zig").UpdatePolicyOutput;
pub const UpdateResponsibilityTransferInput = @import("update_responsibility_transfer.zig").UpdateResponsibilityTransferInput;
pub const UpdateResponsibilityTransferOutput = @import("update_responsibility_transfer.zig").UpdateResponsibilityTransferOutput;
