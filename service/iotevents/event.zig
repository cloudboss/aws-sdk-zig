const Action = @import("action.zig").Action;

/// Specifies the `actions` to be performed when the `condition`
/// evaluates to TRUE.
pub const Event = struct {
    /// The actions to be performed.
    actions: ?[]const Action,

    /// Optional. The Boolean expression that, when TRUE, causes the `actions` to be
    /// performed. If not present, the actions are performed (=TRUE). If the
    /// expression result is not
    /// a Boolean value, the actions are not performed (=FALSE).
    condition: ?[]const u8,

    /// The name of the event.
    event_name: []const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .condition = "condition",
        .event_name = "eventName",
    };
};
