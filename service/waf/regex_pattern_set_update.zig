const ChangeAction = @import("change_action.zig").ChangeAction;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// In an UpdateRegexPatternSet request, `RegexPatternSetUpdate` specifies
/// whether to insert or delete a
/// `RegexPatternString` and includes the settings for the `RegexPatternString`.
pub const RegexPatternSetUpdate = struct {
    /// Specifies whether to insert or delete a `RegexPatternString`.
    action: ChangeAction,

    /// Specifies the regular expression (regex) pattern that you want AWS WAF to
    /// search for, such as `B[a@]dB[o0]t`.
    regex_pattern_string: []const u8,

    pub const json_field_names = .{
        .action = "Action",
        .regex_pattern_string = "RegexPatternString",
    };
};
