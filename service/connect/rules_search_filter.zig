const RuleAttributeFilter = @import("rule_attribute_filter.zig").RuleAttributeFilter;

/// Filters to be applied to search results.
pub const RulesSearchFilter = struct {
    /// An object that can be used to specify tag conditions inside the
    /// `SearchFilter`.
    attribute_filter: ?RuleAttributeFilter = null,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
    };
};
