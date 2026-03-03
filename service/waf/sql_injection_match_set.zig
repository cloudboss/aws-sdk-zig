const SqlInjectionMatchTuple = @import("sql_injection_match_tuple.zig").SqlInjectionMatchTuple;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// A complex type that contains `SqlInjectionMatchTuple` objects, which specify
/// the parts of web requests that you
/// want AWS WAF to inspect for snippets of malicious SQL code and, if you want
/// AWS WAF to inspect a header, the name of the header. If a
/// `SqlInjectionMatchSet` contains more than one `SqlInjectionMatchTuple`
/// object, a request needs to
/// include snippets of SQL code in only one of the specified parts of the
/// request to be considered a match.
pub const SqlInjectionMatchSet = struct {
    /// The name, if any, of the `SqlInjectionMatchSet`.
    name: ?[]const u8 = null,

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

    /// Specifies the parts of web requests that you want to inspect for snippets of
    /// malicious SQL code.
    sql_injection_match_tuples: []const SqlInjectionMatchTuple,

    pub const json_field_names = .{
        .name = "Name",
        .sql_injection_match_set_id = "SqlInjectionMatchSetId",
        .sql_injection_match_tuples = "SqlInjectionMatchTuples",
    };
};
