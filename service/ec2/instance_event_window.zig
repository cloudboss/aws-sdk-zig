const InstanceEventWindowAssociationTarget = @import("instance_event_window_association_target.zig").InstanceEventWindowAssociationTarget;
const InstanceEventWindowState = @import("instance_event_window_state.zig").InstanceEventWindowState;
const Tag = @import("tag.zig").Tag;
const InstanceEventWindowTimeRange = @import("instance_event_window_time_range.zig").InstanceEventWindowTimeRange;

/// The event window.
pub const InstanceEventWindow = struct {
    /// One or more targets associated with the event window.
    association_target: ?InstanceEventWindowAssociationTarget,

    /// The cron expression defined for the event window.
    cron_expression: ?[]const u8,

    /// The ID of the event window.
    instance_event_window_id: ?[]const u8,

    /// The name of the event window.
    name: ?[]const u8,

    /// The current state of the event window.
    state: ?InstanceEventWindowState,

    /// The instance tags associated with the event window.
    tags: ?[]const Tag,

    /// One or more time ranges defined for the event window.
    time_ranges: ?[]const InstanceEventWindowTimeRange,
};
