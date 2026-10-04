const DelegatedAdminConstraint = @import("delegated_admin_constraint.zig").DelegatedAdminConstraint;
const ManagementAccountConstraint = @import("management_account_constraint.zig").ManagementAccountConstraint;

/// A constraint on which AWS account a deployment can be initiated from.
/// Specify one of the supported constraint types.
pub const AccountConstraint = union(enum) {
    delegated_admin: ?DelegatedAdminConstraint,
    management_account: ?ManagementAccountConstraint,

    pub const json_field_names = .{
        .delegated_admin = "delegatedAdmin",
        .management_account = "managementAccount",
    };
};
