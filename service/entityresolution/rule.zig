/// An object containing the `ruleName` and `matchingKeys`.
pub const Rule = struct {
    /// A list of `MatchingKeys`. The `MatchingKeys` must have been defined in the
    /// `SchemaMapping`. Two records are considered to match according to this rule
    /// if all of the `MatchingKeys` match.
    matching_keys: []const []const u8,

    /// A name for the matching rule.
    rule_name: []const u8,

    pub const json_field_names = .{
        .matching_keys = "matchingKeys",
        .rule_name = "ruleName",
    };
};
