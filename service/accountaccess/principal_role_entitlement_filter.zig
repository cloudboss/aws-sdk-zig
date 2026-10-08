const PrincipalFilter = @import("principal_filter.zig").PrincipalFilter;

/// Specifies filter criteria for principal-to-role entitlements. All specified
/// criteria must match for an entitlement to be returned.
pub const PrincipalRoleEntitlementFilter = struct {
    /// The 12-digit Amazon Web Services account ID to filter entitlements by.
    account: ?[]const u8 = null,

    /// The principal to filter entitlements by.
    principal: ?PrincipalFilter = null,

    /// The IAM role ARN to filter entitlements by.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account = "account",
        .principal = "principal",
        .role_arn = "roleArn",
    };
};
