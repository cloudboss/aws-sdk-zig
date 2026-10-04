/// The configuration for a threat category-based filtering rule. This specifies
/// which threat category to use for DNS query evaluation.
pub const FirewallAdvancedThreatCategoryConfig = struct {
    /// The threat category identifier. To retrieve the list of available threat
    /// categories, call ListFirewallRuleTypes with `RuleType` set to
    /// `FirewallAdvancedThreatCategory`.
    category: []const u8,

    pub const json_field_names = .{
        .category = "Category",
    };
};
