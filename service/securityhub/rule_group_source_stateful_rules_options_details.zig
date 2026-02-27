/// A rule option for a stateful rule.
pub const RuleGroupSourceStatefulRulesOptionsDetails = struct {
    /// A keyword to look for.
    keyword: ?[]const u8,

    /// A list of settings.
    settings: ?[]const []const u8,

    pub const json_field_names = .{
        .keyword = "Keyword",
        .settings = "Settings",
    };
};
