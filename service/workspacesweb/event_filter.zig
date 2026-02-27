const Unit = @import("unit.zig").Unit;
const Event = @import("event.zig").Event;

/// The filter that specifies the events to monitor.
pub const EventFilter = union(enum) {
    /// The filter that monitors all of the available events, including any new
    /// events emitted in the future.
    all: ?Unit,
    /// The filter that monitors only the listed set of events. New events are not
    /// auto-monitored.
    include: ?[]const Event,

    pub const json_field_names = .{
        .all = "all",
        .include = "include",
    };
};
