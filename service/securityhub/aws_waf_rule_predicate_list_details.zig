/// Provides details about the `ByteMatchSet`, `IPSet`, `SqlInjectionMatchSet`,
/// `XssMatchSet`,
/// `RegexMatchSet`, `GeoMatchSet`, and `SizeConstraintSet` objects that you
/// want to add to a rule and,
/// for each object, indicates whether you want to negate the settings.
pub const AwsWafRulePredicateListDetails = struct {
    /// A unique identifier for a predicate in a rule, such as `ByteMatchSetId` or
    /// `IPSetId`.
    data_id: ?[]const u8 = null,

    /// Specifies if you want WAF to allow, block, or count requests based on the
    /// settings in the
    /// `ByteMatchSet`, `IPSet`, `SqlInjectionMatchSet`, `XssMatchSet`,
    /// `RegexMatchSet`, `GeoMatchSet`, or `SizeConstraintSet`.
    negated: ?bool = null,

    /// The type of predicate in a rule, such as `ByteMatch` or `IPSet`.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .data_id = "DataId",
        .negated = "Negated",
        .@"type" = "Type",
    };
};
