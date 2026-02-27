const AutoRollbackEvent = @import("auto_rollback_event.zig").AutoRollbackEvent;

/// Information about a configuration for automatically rolling back to a
/// previous version
/// of an application revision when a deployment is not completed successfully.
pub const AutoRollbackConfiguration = struct {
    /// Indicates whether a defined automatic rollback configuration is currently
    /// enabled.
    enabled: bool = false,

    /// The event type or types that trigger a rollback.
    events: ?[]const AutoRollbackEvent,

    pub const json_field_names = .{
        .enabled = "enabled",
        .events = "events",
    };
};
