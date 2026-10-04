/// Contains the detection logic for a custom detection rule.
pub const RuleDefinition = struct {
    /// The detection logic expression for the rule.
    expression: []const u8,

    pub const json_field_names = .{
        .expression = "Expression",
    };
};
