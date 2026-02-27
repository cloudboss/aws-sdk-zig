/// Represents a task list.
pub const TaskList = struct {
    /// The name of the task list.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
