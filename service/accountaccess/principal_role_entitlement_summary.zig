const Principal = @import("principal.zig").Principal;

/// Contains summary information about a principal-to-role entitlement.
pub const PrincipalRoleEntitlementSummary = struct {
    /// The 12-digit Amazon Web Services account ID where the IAM role resides.
    account: []const u8,

    /// The friendly name of the Amazon Web Services account where the IAM role
    /// resides.
    account_name: ?[]const u8 = null,

    /// The principal (user or group) that is granted access to assume the IAM role.
    principal: Principal,

    /// The ARN of the IAM role that the principal can assume.
    role_arn: []const u8,

    pub const json_field_names = .{
        .account = "account",
        .account_name = "accountName",
        .principal = "principal",
        .role_arn = "roleArn",
    };
};
