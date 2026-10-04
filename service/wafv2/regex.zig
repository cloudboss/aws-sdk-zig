/// A single regular expression. This is used in a RegexPatternSet and
/// also in the configuration for the Amazon Web Services Managed Rules rule
/// group `AWSManagedRulesAntiDDoSRuleSet`.
pub const Regex = struct {
    /// The string representing the regular expression. WAF enforces a quota on the
    /// maximum number of characters in a regex pattern. For the current limit, see
    /// [WAF
    /// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
    /// in the *WAF Developer Guide*.
    regex_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .regex_string = "RegexString",
    };
};
