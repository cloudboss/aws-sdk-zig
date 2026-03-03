/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The `RegexPatternSet` specifies the regular expression (regex) pattern that
/// you want AWS WAF to search for, such as `B[a@]dB[o0]t`. You can then
/// configure AWS WAF to reject those requests.
pub const RegexPatternSet = struct {
    /// A friendly name or description of the RegexPatternSet. You can't change
    /// `Name` after you create a `RegexPatternSet`.
    name: ?[]const u8 = null,

    /// The identifier for the `RegexPatternSet`. You use `RegexPatternSetId` to get
    /// information about a `RegexPatternSet`,
    /// update a `RegexPatternSet`, remove a `RegexPatternSet` from a
    /// `RegexMatchSet`, and delete a `RegexPatternSet` from AWS WAF.
    ///
    /// `RegexMatchSetId` is returned by CreateRegexPatternSet and by
    /// ListRegexPatternSets.
    regex_pattern_set_id: []const u8,

    /// Specifies the regular expression (regex) patterns that you want AWS WAF to
    /// search for, such as `B[a@]dB[o0]t`.
    regex_pattern_strings: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .regex_pattern_set_id = "RegexPatternSetId",
        .regex_pattern_strings = "RegexPatternStrings",
    };
};
