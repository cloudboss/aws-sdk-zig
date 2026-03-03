const CustomEventsStatus = @import("custom_events_status.zig").CustomEventsStatus;

/// A structure that contains information about custom events for this app
/// monitor.
pub const CustomEvents = struct {
    /// Specifies whether this app monitor allows the web client to define and send
    /// custom events. The default is for custom events to be `DISABLED`.
    status: ?CustomEventsStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
