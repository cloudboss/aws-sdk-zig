/// A single regular expression. This is used in a RegexPatternSet and
/// also in the configuration for the Amazon Web Services Managed Rules rule
/// group `AWSManagedRulesAntiDDoSRuleSet`.
pub const Regex = struct {
    /// The string representing the regular expression.
    regex_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .regex_string = "RegexString",
    };
};
