/// Content of a goal
pub const GoalContent = struct {
    /// A detailed description of the goal.
    description: []const u8,

    /// The objectives to be achieved for this goal.
    objectives: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .objectives = "objectives",
    };
};
