const InsightsEvent = @import("insights_event.zig").InsightsEvent;

/// An email's insights contain metadata and delivery information about a
/// specific email.
pub const EmailInsights = struct {
    /// The recipient of the email.
    destination: ?[]const u8,

    /// A list of events associated with the sent email.
    events: ?[]const InsightsEvent,

    /// The recipient's ISP (e.g., `Gmail`, `Yahoo`,
    /// etc.).
    isp: ?[]const u8,

    pub const json_field_names = .{
        .destination = "Destination",
        .events = "Events",
        .isp = "Isp",
    };
};
