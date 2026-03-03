/// A rule set contains a list of rules that are evaluated in order. Each rule
/// is evaluated sequentially for each email.
pub const RuleSet = struct {
    /// The last modification date of the rule set.
    last_modification_date: ?i64 = null,

    /// The identifier of the rule set.
    rule_set_id: ?[]const u8 = null,

    /// A user-friendly name for the rule set.
    rule_set_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_modification_date = "LastModificationDate",
        .rule_set_id = "RuleSetId",
        .rule_set_name = "RuleSetName",
    };
};
