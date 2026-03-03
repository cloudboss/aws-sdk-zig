/// Error information returned when a
/// [DescribeEventDetails](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventDetails.html) operation can't find a specified event.
pub const EventDetailsErrorItem = struct {
    /// A message that describes the error.
    error_message: ?[]const u8 = null,

    /// The name of the error.
    error_name: ?[]const u8 = null,

    /// The unique identifier for the event. The event ARN has the
    /// `arn:aws:health:*event-region*::event/*SERVICE*/*EVENT_TYPE_CODE*/*EVENT_TYPE_PLUS_ID*
    /// `
    /// format.
    ///
    /// For example, an event ARN might look like the following:
    ///
    /// `arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-DEF456`
    event_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .error_name = "errorName",
        .event_arn = "eventArn",
    };
};
