const NotifyOnState = @import("notify_on_state.zig").NotifyOnState;

/// The notification configuration for a notebook run in Amazon SageMaker
/// Unified Studio.
pub const NotificationConfig = struct {
    /// Notebook run states that trigger notifications. Ordering is not significant.
    notify_on: []const NotifyOnState,

    pub const json_field_names = .{
        .notify_on = "notifyOn",
    };
};
