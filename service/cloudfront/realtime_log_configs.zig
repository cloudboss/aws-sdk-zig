const RealtimeLogConfig = @import("realtime_log_config.zig").RealtimeLogConfig;

/// A list of real-time log configurations.
pub const RealtimeLogConfigs = struct {
    /// A flag that indicates whether there are more real-time log configurations
    /// than are contained in this list.
    is_truncated: bool,

    /// Contains the list of real-time log configurations.
    items: ?[]const RealtimeLogConfig,

    /// This parameter indicates where this list of real-time log configurations
    /// begins. This list includes real-time log configurations that occur after the
    /// marker.
    marker: []const u8,

    /// The maximum number of real-time log configurations requested.
    max_items: i32,

    /// If there are more items in the list than are in this response, this element
    /// is present. It contains the value that you should use in the `Marker` field
    /// of a subsequent request to continue listing real-time log configurations
    /// where you left off.
    next_marker: ?[]const u8,
};
