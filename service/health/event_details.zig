const aws = @import("aws");

const Event = @import("event.zig").Event;
const EventDescription = @import("event_description.zig").EventDescription;

/// Detailed information about an event. A combination of an
/// [Event](https://docs.aws.amazon.com/health/latest/APIReference/API_Event.html) object, an [EventDescription](https://docs.aws.amazon.com/health/latest/APIReference/API_EventDescription.html) object, and additional metadata about the event. Returned by
/// the
/// [DescribeEventDetails](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventDetails.html) operation.
pub const EventDetails = struct {
    /// Summary information about the event.
    event: ?Event,

    /// The most recent description of the event.
    event_description: ?EventDescription,

    /// Additional metadata about the event.
    event_metadata: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .event = "event",
        .event_description = "eventDescription",
        .event_metadata = "eventMetadata",
    };
};
