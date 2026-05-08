const PrincipalMatchOperator = @import("principal_match_operator.zig").PrincipalMatchOperator;

/// An IAM principal specification for rule matching.
pub const IamPrincipal = struct {
    /// The Amazon Resource Name (ARN) of the IAM principal. Supports user, role,
    /// and assumed-role ARNs. Wildcards can be used with the `StringLike` operator.
    arn: []const u8,

    /// The match operator. `StringEquals` requires an exact match. `StringLike`
    /// supports wildcard patterns using `*` and `?`.
    operator: ?PrincipalMatchOperator = null,

    pub const json_field_names = .{
        .arn = "arn",
        .operator = "operator",
    };
};
