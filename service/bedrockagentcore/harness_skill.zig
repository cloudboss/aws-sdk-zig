/// A skill available to the agent.
pub const HarnessSkill = union(enum) {
    /// The filesystem path to the skill definition.
    path: ?[]const u8,

    pub const json_field_names = .{
        .path = "path",
    };
};
