const aws = @import("aws");

const AttributeDimension = @import("attribute_dimension.zig").AttributeDimension;
const SetDimension = @import("set_dimension.zig").SetDimension;
const MetricDimension = @import("metric_dimension.zig").MetricDimension;

/// Specifies the dimensions for an event filter that determines when a campaign
/// is sent or a journey activity is performed.
pub const EventDimensions = struct {
    /// One or more custom attributes that your application reports to Amazon
    /// Pinpoint. You can use these attributes as selection criteria when you create
    /// an event filter.
    attributes: ?[]const aws.map.MapEntry(AttributeDimension),

    /// The name of the event that causes the campaign to be sent or the journey
    /// activity to be performed. This can be a standard event that Amazon Pinpoint
    /// generates, such as _email.delivered. For campaigns, this can also be a
    /// custom event that's specific to your application. For information about
    /// standard events, see [Streaming Amazon Pinpoint
    /// Events](https://docs.aws.amazon.com/pinpoint/latest/developerguide/event-streams.html) in the *Amazon Pinpoint Developer Guide*.
    event_type: ?SetDimension,

    /// One or more custom metrics that your application reports to Amazon Pinpoint.
    /// You can use these metrics as selection criteria when you create an event
    /// filter.
    metrics: ?[]const aws.map.MapEntry(MetricDimension),

    pub const json_field_names = .{
        .attributes = "Attributes",
        .event_type = "EventType",
        .metrics = "Metrics",
    };
};
