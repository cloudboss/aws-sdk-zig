/// Describes the action that WAF should take on a web request when it matches
/// the criteria defined in the rule.
pub const AwsWafRegionalRuleGroupRulesActionDetails = struct {
    /// Specifies the `ByteMatchSet`, `IPSet`, `SqlInjectionMatchSet`,
    /// `XssMatchSet`, `RegexMatchSet`,
    /// `GeoMatchSet`, and `SizeConstraintSet` objects that you want to add to a
    /// rule and, for each object, indicates whether you want to negate the
    /// settings.
    type: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
    };
};
