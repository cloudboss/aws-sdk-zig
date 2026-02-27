const ChangeAction = @import("change_action.zig").ChangeAction;
const RegexMatchTuple = @import("regex_match_tuple.zig").RegexMatchTuple;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// In an UpdateRegexMatchSet request, `RegexMatchSetUpdate` specifies whether
/// to insert or delete a
/// RegexMatchTuple and includes the settings for the `RegexMatchTuple`.
pub const RegexMatchSetUpdate = struct {
    /// Specifies whether to insert or delete a RegexMatchTuple.
    action: ChangeAction,

    /// Information about the part of a web request that you want AWS WAF to inspect
    /// and the identifier of the regular expression (regex) pattern that you want
    /// AWS WAF to search for.
    /// If you specify `DELETE` for the value of `Action`, the `RegexMatchTuple`
    /// values must
    /// exactly match the values in the `RegexMatchTuple` that you want to delete
    /// from the `RegexMatchSet`.
    regex_match_tuple: RegexMatchTuple,

    pub const json_field_names = .{
        .action = "Action",
        .regex_match_tuple = "RegexMatchTuple",
    };
};
