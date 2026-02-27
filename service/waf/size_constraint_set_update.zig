const ChangeAction = @import("change_action.zig").ChangeAction;
const SizeConstraint = @import("size_constraint.zig").SizeConstraint;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Specifies the part of a web request that you want to inspect the size of and
/// indicates whether you want to
/// add the specification to a SizeConstraintSet or delete it from a
/// `SizeConstraintSet`.
pub const SizeConstraintSetUpdate = struct {
    /// Specify `INSERT` to add a SizeConstraintSetUpdate to a SizeConstraintSet.
    /// Use `DELETE` to remove a `SizeConstraintSetUpdate` from a
    /// `SizeConstraintSet`.
    action: ChangeAction,

    /// Specifies a constraint on the size of a part of the web request. AWS WAF
    /// uses the `Size`, `ComparisonOperator`, and `FieldToMatch` to build
    /// an expression in the form of "`Size`
    /// `ComparisonOperator` size in bytes of `FieldToMatch`". If that expression is
    /// true, the
    /// `SizeConstraint` is considered to match.
    size_constraint: SizeConstraint,

    pub const json_field_names = .{
        .action = "Action",
        .size_constraint = "SizeConstraint",
    };
};
