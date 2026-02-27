const UserUnion = @import("user_union.zig").UserUnion;

/// Information of the user which performed the audit.
pub const AuditEventPerformedBy = struct {
    /// Unique identifier of an IAM role.
    iam_principal_arn: []const u8,

    user: ?UserUnion,

    pub const json_field_names = .{
        .iam_principal_arn = "iamPrincipalArn",
        .user = "user",
    };
};
