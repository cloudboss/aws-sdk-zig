const PermissionModelType = @import("permission_model_type.zig").PermissionModelType;

/// Defines the roles and credentials that Resilience Hub would use while
/// creating the
/// application, importing its resources, and running an assessment.
pub const PermissionModel = struct {
    /// Defines a list of role Amazon Resource Names (ARNs) to be used in other
    /// accounts. These
    /// ARNs are used for querying purposes while importing resources and assessing
    /// your
    /// application.
    ///
    /// * These ARNs are required only when your resources are in other accounts and
    ///   you have
    /// different role name in these accounts. Else, the invoker role name will be
    /// used in the
    /// other accounts.
    ///
    /// * These roles must have a trust policy with `iam:AssumeRole` permission to
    /// the invoker role in the primary account.
    cross_account_role_arns: ?[]const []const u8,

    /// Existing Amazon Web Services
    /// IAM role name in the primary Amazon Web Services account that will be
    /// assumed by
    /// Resilience Hub Service Principle to obtain a read-only access to your
    /// application
    /// resources while running an assessment.
    ///
    /// If your IAM role includes a path, you must include the path in the
    /// `invokerRoleName` parameter.
    /// For example, if your IAM role's ARN is
    /// `arn:aws:iam:123456789012:role/my-path/role-name`, you should pass
    /// `my-path/role-name`.
    ///
    /// * You must have `iam:passRole` permission for this role while creating or
    /// updating the application.
    ///
    /// * Currently, `invokerRoleName` accepts only `[A-Za-z0-9_+=,.@-]`
    /// characters.
    invoker_role_name: ?[]const u8,

    /// Defines how Resilience Hub scans your resources. It can scan for the
    /// resources by
    /// using a pre-existing role in your Amazon Web Services account, or by using
    /// the credentials of
    /// the current IAM user.
    @"type": PermissionModelType,

    pub const json_field_names = .{
        .cross_account_role_arns = "crossAccountRoleArns",
        .invoker_role_name = "invokerRoleName",
        .@"type" = "type",
    };
};
