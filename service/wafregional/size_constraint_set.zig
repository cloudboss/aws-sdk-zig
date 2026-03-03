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
/// A complex type that contains `SizeConstraint` objects, which specify the
/// parts of web requests that you
/// want AWS WAF to inspect the size of. If a `SizeConstraintSet` contains more
/// than one `SizeConstraint`
/// object, a request only needs to match one constraint to be considered a
/// match.
pub const SizeConstraintSet = struct {
    /// The name, if any, of the `SizeConstraintSet`.
    name: ?[]const u8 = null,

    /// Specifies the parts of web requests that you want to inspect the size of.
    size_constraints: []const SizeConstraint,

    /// A unique identifier for a `SizeConstraintSet`. You use `SizeConstraintSetId`
    /// to get information about a
    /// `SizeConstraintSet` (see GetSizeConstraintSet), update a `SizeConstraintSet`
    /// (see UpdateSizeConstraintSet), insert a `SizeConstraintSet` into a `Rule` or
    /// delete one from a `Rule` (see UpdateRule), and delete a `SizeConstraintSet`
    /// from AWS WAF
    /// (see DeleteSizeConstraintSet).
    ///
    /// `SizeConstraintSetId` is returned by CreateSizeConstraintSet and by
    /// ListSizeConstraintSets.
    size_constraint_set_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .size_constraints = "SizeConstraints",
        .size_constraint_set_id = "SizeConstraintSetId",
    };
};
