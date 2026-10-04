/// The configuration for a content category-based filtering rule. This
/// specifies which content category to use for DNS query evaluation.
pub const FirewallAdvancedContentCategoryConfig = struct {
    /// The content category identifier. To retrieve the list of available content
    /// categories, call ListFirewallRuleTypes with `RuleType` set to
    /// `FirewallAdvancedContentCategory`.
    category: []const u8,

    pub const json_field_names = .{
        .category = "Category",
    };
};
