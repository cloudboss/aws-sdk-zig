const ChangeAction = @import("change_action.zig").ChangeAction;
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
/// Specifies the part of a web request that you want to inspect for snippets of
/// malicious SQL code and indicates whether you want to
/// add the specification to a SqlInjectionMatchSet or delete it from a
/// `SqlInjectionMatchSet`.
pub const SqlInjectionMatchSetUpdate = struct {
    /// Specify `INSERT` to add a SqlInjectionMatchSetUpdate to a
    /// SqlInjectionMatchSet.
    /// Use `DELETE` to remove a `SqlInjectionMatchSetUpdate` from a
    /// `SqlInjectionMatchSet`.
    action: ChangeAction,

    /// Specifies the part of a web request that you want AWS WAF to inspect for
    /// snippets of malicious SQL code and, if you want AWS WAF to inspect a header,
    /// the name of the header.
    sql_injection_match_tuple: SqlInjectionMatchTuple,

    pub const json_field_names = .{
        .action = "Action",
        .sql_injection_match_tuple = "SqlInjectionMatchTuple",
    };
};
