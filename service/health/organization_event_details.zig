const aws = @import("aws");

const Event = @import("event.zig").Event;
const EventDescription = @import("event_description.zig").EventDescription;

/// Detailed information about an event. A combination of an
/// [Event](https://docs.aws.amazon.com/health/latest/APIReference/API_Event.html) object, an [EventDescription](https://docs.aws.amazon.com/health/latest/APIReference/API_EventDescription.html) object, and additional metadata about the event. Returned by
/// the
/// [DescribeEventDetailsForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventDetailsForOrganization.html) operation.
pub const OrganizationEventDetails = struct {
    /// The 12-digit Amazon Web Services account numbers that contains the affected
    /// entities.
    aws_account_id: ?[]const u8 = null,

    event: ?Event = null,

    event_description: ?EventDescription = null,

    /// Additional metadata about the event.
    event_metadata: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .event = "event",
        .event_description = "eventDescription",
        .event_metadata = "eventMetadata",
    };
};
