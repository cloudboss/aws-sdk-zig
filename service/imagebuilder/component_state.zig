const ComponentStatus = @import("component_status.zig").ComponentStatus;

/// A group of fields that describe the current status of components.
pub const ComponentState = struct {
    /// Describes how or why the component changed state.
    reason: ?[]const u8,

    /// The current state of the component.
    status: ?ComponentStatus,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
