const DatasetActionType = @import("dataset_action_type.zig").DatasetActionType;

/// Information about the action that automatically creates the dataset's
/// contents.
pub const DatasetActionSummary = struct {
    /// The name of the action that automatically creates the dataset's contents.
    action_name: ?[]const u8 = null,

    /// The type of action by which the dataset's contents are automatically
    /// created.
    action_type: ?DatasetActionType = null,

    pub const json_field_names = .{
        .action_name = "actionName",
        .action_type = "actionType",
    };
};
