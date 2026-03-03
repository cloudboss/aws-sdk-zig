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
    arn: ?[]const u8,

    /// The unique identifier (ID) for the root. The ID is unique to the
    /// organization
    /// only.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a root ID string
    /// requires "r-" followed by
    /// from 4 to 32 lowercase letters or digits.
    id: ?[]const u8,

    /// The friendly name of the root.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of any of the characters
    /// in the ASCII
    /// character range.
    name: ?[]const u8,

    /// The types of policies that are currently enabled for the root and therefore
    /// can be
    /// attached to the root or to its OUs or accounts.
    ///
    /// Even if a policy type is shown as available in the organization, you can
    /// separately enable and disable them at the root level by using
    /// EnablePolicyType and DisablePolicyType. Use DescribeOrganization to see the
    /// availability of the policy types in
    /// that organization.
    policy_types: ?[]const PolicyTypeSummary,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
        .policy_types = "PolicyTypes",
    };
};

pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const accept_handshake = @import("accept_handshake.zig");
pub const attach_policy = @import("attach_policy.zig");
pub const cancel_handshake = @import("cancel_handshake.zig");
pub const close_account = @import("close_account.zig");
pub const create_account = @import("create_account.zig");
pub const create_gov_cloud_account = @import("create_gov_cloud_account.zig");
pub const create_organization = @import("create_organization.zig");
pub const create_organizational_unit = @import("create_organizational_unit.zig");
pub const create_policy = @import("create_policy.zig");
pub const decline_handshake = @import("decline_handshake.zig");
pub const delete_organization = @import("delete_organization.zig");
pub const delete_organizational_unit = @import("delete_organizational_unit.zig");
pub const delete_policy = @import("delete_policy.zig");
pub const delete_resource_policy = @import("delete_resource_policy.zig");
pub const deregister_delegated_administrator = @import("deregister_delegated_administrator.zig");
pub const describe_account = @import("describe_account.zig");
pub const describe_create_account_status = @import("describe_create_account_status.zig");
pub const describe_effective_policy = @import("describe_effective_policy.zig");
pub const describe_handshake = @import("describe_handshake.zig");
pub const describe_organization = @import("describe_organization.zig");
pub const describe_organizational_unit = @import("describe_organizational_unit.zig");
pub const describe_policy = @import("describe_policy.zig");
pub const describe_resource_policy = @import("describe_resource_policy.zig");
pub const describe_responsibility_transfer = @import("describe_responsibility_transfer.zig");
pub const detach_policy = @import("detach_policy.zig");
pub const disable_aws_service_access = @import("disable_aws_service_access.zig");
pub const disable_policy_type = @import("disable_policy_type.zig");
pub const enable_all_features = @import("enable_all_features.zig");
pub const enable_aws_service_access = @import("enable_aws_service_access.zig");
pub const enable_policy_type = @import("enable_policy_type.zig");
pub const invite_account_to_organization = @import("invite_account_to_organization.zig");
pub const invite_organization_to_transfer_responsibility = @import("invite_organization_to_transfer_responsibility.zig");
pub const leave_organization = @import("leave_organization.zig");
pub const list_accounts = @import("list_accounts.zig");
pub const list_accounts_for_parent = @import("list_accounts_for_parent.zig");
pub const list_accounts_with_invalid_effective_policy = @import("list_accounts_with_invalid_effective_policy.zig");
pub const list_aws_service_access_for_organization = @import("list_aws_service_access_for_organization.zig");
pub const list_children = @import("list_children.zig");
pub const list_create_account_status = @import("list_create_account_status.zig");
pub const list_delegated_administrators = @import("list_delegated_administrators.zig");
pub const list_delegated_services_for_account = @import("list_delegated_services_for_account.zig");
pub const list_effective_policy_validation_errors = @import("list_effective_policy_validation_errors.zig");
pub const list_handshakes_for_account = @import("list_handshakes_for_account.zig");
pub const list_handshakes_for_organization = @import("list_handshakes_for_organization.zig");
pub const list_inbound_responsibility_transfers = @import("list_inbound_responsibility_transfers.zig");
pub const list_organizational_units_for_parent = @import("list_organizational_units_for_parent.zig");
pub const list_outbound_responsibility_transfers = @import("list_outbound_responsibility_transfers.zig");
pub const list_parents = @import("list_parents.zig");
pub const list_policies = @import("list_policies.zig");
pub const list_policies_for_target = @import("list_policies_for_target.zig");
pub const list_roots = @import("list_roots.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const list_targets_for_policy = @import("list_targets_for_policy.zig");
pub const move_account = @import("move_account.zig");
pub const put_resource_policy = @import("put_resource_policy.zig");
pub const register_delegated_administrator = @import("register_delegated_administrator.zig");
pub const remove_account_from_organization = @import("remove_account_from_organization.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const terminate_responsibility_transfer = @import("terminate_responsibility_transfer.zig");
pub const untag_resource = @import("untag_resource.zig");
pub const update_organizational_unit = @import("update_organizational_unit.zig");
pub const update_policy = @import("update_policy.zig");
pub const update_responsibility_transfer = @import("update_responsibility_transfer.zig");
