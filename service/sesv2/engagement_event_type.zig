/// The type of delivery events:
///
/// * `OPEN` - Open event for emails including open trackers.
/// Excludes opens for emails addressed to more than one recipient.
///
/// * `CLICK` - Click event for emails including wrapped links.
/// Excludes clicks for emails addressed to more than one recipient.
pub const EngagementEventType = enum {
    open,
    click,

    pub const json_field_names = .{
        .open = "OPEN",
        .click = "CLICK",
    };
};
