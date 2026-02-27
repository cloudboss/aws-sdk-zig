/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Returned by ListRegexMatchSets. Each `RegexMatchSetSummary` object includes
/// the `Name` and
/// `RegexMatchSetId` for one RegexMatchSet.
pub const RegexMatchSetSummary = struct {
    /// A friendly name or description of the RegexMatchSet. You can't change `Name`
    /// after you create a `RegexMatchSet`.
    name: []const u8,

    /// The `RegexMatchSetId` for a `RegexMatchSet`. You use `RegexMatchSetId` to
    /// get information about a `RegexMatchSet`,
    /// update a `RegexMatchSet`, remove a `RegexMatchSet` from a `Rule`, and delete
    /// a `RegexMatchSet` from AWS WAF.
    ///
    /// `RegexMatchSetId` is returned by CreateRegexMatchSet and by
    /// ListRegexMatchSets.
    regex_match_set_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .regex_match_set_id = "RegexMatchSetId",
    };
};
