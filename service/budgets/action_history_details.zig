const Action = @import("action.zig").Action;

/// The description of the details for the event.
pub const ActionHistoryDetails = struct {
    /// The budget action resource.
    action: Action,

    message: []const u8,

    pub const json_field_names = .{
        .action = "Action",
        .message = "Message",
    };
};
