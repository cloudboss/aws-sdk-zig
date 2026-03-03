const PrincipalType = @import("principal_type.zig").PrincipalType;

/// The assignment that indicates a principal's limited access to a specified
/// Amazon Web Services account with a specified permission set.
///
/// The term *principal* here refers to a user or group that is defined in IAM
/// Identity Center.
pub const AccountAssignment = struct {
    /// The identifier of the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    /// The ARN of the permission set. For more information about ARNs, see [Amazon
    /// Resource Names (ARNs) and Amazon Web Services Service
    /// Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon
    /// Web Services General Reference*.
    permission_set_arn: ?[]const u8 = null,

    /// An identifier for an object in IAM Identity Center, such as a user or group.
    /// PrincipalIds are GUIDs (For example, f81d4fae-7dec-11d0-a765-00a0c91e6bf6).
    /// For more information about PrincipalIds in IAM Identity Center, see the [IAM
    /// Identity Center Identity Store API
    /// Reference](/singlesignon/latest/IdentityStoreAPIReference/welcome.html).
    principal_id: ?[]const u8 = null,

    /// The entity type for which the assignment will be created.
    principal_type: ?PrincipalType = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .permission_set_arn = "PermissionSetArn",
        .principal_id = "PrincipalId",
        .principal_type = "PrincipalType",
    };
};
