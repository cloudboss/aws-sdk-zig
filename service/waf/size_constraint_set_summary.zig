/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The `Id` and `Name` of a `SizeConstraintSet`.
pub const SizeConstraintSetSummary = struct {
    /// The name of the `SizeConstraintSet`, if any.
    name: []const u8,

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
        .size_constraint_set_id = "SizeConstraintSetId",
    };
};
