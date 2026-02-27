/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The `Id` and `Name` of a `SqlInjectionMatchSet`.
pub const SqlInjectionMatchSetSummary = struct {
    /// The name of the `SqlInjectionMatchSet`, if any, specified by `Id`.
    name: []const u8,

    /// A unique identifier for a `SqlInjectionMatchSet`. You use
    /// `SqlInjectionMatchSetId` to get information about a
    /// `SqlInjectionMatchSet` (see GetSqlInjectionMatchSet), update a
    /// `SqlInjectionMatchSet`
    /// (see UpdateSqlInjectionMatchSet), insert a `SqlInjectionMatchSet` into a
    /// `Rule` or
    /// delete one from a `Rule` (see UpdateRule), and delete a
    /// `SqlInjectionMatchSet` from AWS WAF
    /// (see DeleteSqlInjectionMatchSet).
    ///
    /// `SqlInjectionMatchSetId` is returned by CreateSqlInjectionMatchSet and by
    /// ListSqlInjectionMatchSets.
    sql_injection_match_set_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .sql_injection_match_set_id = "SqlInjectionMatchSetId",
    };
};
