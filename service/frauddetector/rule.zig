/// A rule.
pub const Rule = struct {
    /// The detector for which the rule is associated.
    detector_id: []const u8,

    /// The rule ID.
    rule_id: []const u8,

    /// The rule version.
    rule_version: []const u8,

    pub const json_field_names = .{
        .detector_id = "detectorId",
        .rule_id = "ruleId",
        .rule_version = "ruleVersion",
    };
};
