/// A list of schedule actions to delete.
pub const BatchScheduleActionDeleteRequest = struct {
    /// A list of schedule actions to delete.
    action_names: []const []const u8,

    pub const json_field_names = .{
        .action_names = "ActionNames",
    };
};
