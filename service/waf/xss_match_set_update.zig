const ChangeAction = @import("change_action.zig").ChangeAction;
const XssMatchTuple = @import("xss_match_tuple.zig").XssMatchTuple;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Specifies the part of a web request that you want to inspect for cross-site
/// scripting attacks and indicates whether you want to
/// add the specification to an XssMatchSet or delete it from an `XssMatchSet`.
pub const XssMatchSetUpdate = struct {
    /// Specify `INSERT` to add an
    /// XssMatchSetUpdate to an XssMatchSet. Use
    /// `DELETE` to remove an
    /// `XssMatchSetUpdate` from an `XssMatchSet`.
    action: ChangeAction,

    /// Specifies the part of a web request that you want AWS WAF to inspect for
    /// cross-site scripting attacks and, if you want AWS WAF to inspect a header,
    /// the name of the header.
    xss_match_tuple: XssMatchTuple,

    pub const json_field_names = .{
        .action = "Action",
        .xss_match_tuple = "XssMatchTuple",
    };
};
