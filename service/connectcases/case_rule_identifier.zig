/// Object containing case rule identifier information.
pub const CaseRuleIdentifier = struct {
    /// Unique identifier of a case rule.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
