const PrincipalType = @import("principal_type.zig").PrincipalType;

/// A structure that describes an assignment of an Amazon Web Services account
/// to a principal and the permissions that principal has in the account.
pub const AccountAssignmentForPrincipal = struct {
    /// The account ID number of the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    /// The ARN of the IAM Identity Center permission set assigned to this principal
    /// for this Amazon Web Services account.
    permission_set_arn: ?[]const u8 = null,

    /// The ID of the principal.
    principal_id: ?[]const u8 = null,

    /// The type of the principal.
    principal_type: ?PrincipalType = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .permission_set_arn = "PermissionSetArn",
        .principal_id = "PrincipalId",
        .principal_type = "PrincipalType",
    };
};
