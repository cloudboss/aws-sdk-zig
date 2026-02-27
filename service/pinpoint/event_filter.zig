const EventDimensions = @import("event_dimensions.zig").EventDimensions;
const FilterType = @import("filter_type.zig").FilterType;

/// Specifies the settings for an event that causes a campaign to be sent or a
/// journey activity to be performed.
pub const EventFilter = struct {
    /// The dimensions for the event filter to use for the campaign or the journey
    /// activity.
    dimensions: EventDimensions,

    /// The type of event that causes the campaign to be sent or the journey
    /// activity to be performed. Valid values are: SYSTEM, sends the campaign or
    /// performs the activity when a system event occurs; and, ENDPOINT, sends the
    /// campaign or performs the activity when an endpoint event (Events resource)
    /// occurs.
    filter_type: FilterType,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .filter_type = "FilterType",
    };
};
