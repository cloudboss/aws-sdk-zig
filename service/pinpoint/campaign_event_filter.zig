const EventDimensions = @import("event_dimensions.zig").EventDimensions;
const FilterType = @import("filter_type.zig").FilterType;

/// Specifies the settings for events that cause a campaign to be sent.
pub const CampaignEventFilter = struct {
    /// The dimension settings of the event filter for the campaign.
    dimensions: EventDimensions,

    /// The type of event that causes the campaign to be sent. Valid values are:
    /// SYSTEM, sends the campaign when a system event occurs; and, ENDPOINT, sends
    /// the campaign when an endpoint event (Events resource) occurs.
    filter_type: FilterType,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .filter_type = "FilterType",
    };
};
