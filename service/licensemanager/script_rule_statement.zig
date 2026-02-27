/// Rule statement that uses a script to evaluate license asset conditions.
pub const ScriptRuleStatement = struct {
    /// Key name to match against in the script rule evaluation.
    key_to_match: []const u8,

    /// Script code used to evaluate the rule condition.
    script: []const u8,

    pub const json_field_names = .{
        .key_to_match = "KeyToMatch",
        .script = "Script",
    };
};
