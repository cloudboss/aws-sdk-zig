const Principal = @import("principal.zig").Principal;

/// Specifies a principal-to-role entitlement that grants an IAM Identity Center
/// principal permission to assume an IAM role.
pub const PrincipalRoleEntitlement = struct {
    /// The principal (user or group) that is granted access to assume the IAM role.
    principal: Principal,

    /// The ARN of the IAM role that the principal can assume.
    role_arn: []const u8,

    pub const json_field_names = .{
        .principal = "principal",
        .role_arn = "roleArn",
    };
};
