/// A list of port ranges.
pub const RuleGroupVariablesPortSetsDetails = struct {
    /// The list of port ranges.
    definition: ?[]const []const u8,

    pub const json_field_names = .{
        .definition = "Definition",
    };
};
