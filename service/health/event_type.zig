const EventTypeActionability = @import("event_type_actionability.zig").EventTypeActionability;
const eventTypeCategory = @import("event_type_category.zig").eventTypeCategory;
const EventTypePersona = @import("event_type_persona.zig").EventTypePersona;

/// Contains the metadata about a type of event that is reported by Health. The
/// `EventType` shows the category, service, and the event type code of the
/// event. For example, an `issue` might be the category, `EC2` the
/// service, and `AWS_EC2_SYSTEM_MAINTENANCE_EVENT` the event type code.
///
/// You can use the
/// [DescribeEventTypes](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventTypes.html) API operation to return this information
/// about an event.
///
/// You can also use the Amazon CloudWatch Events console to create a rule so
/// that you can get notified or
/// take action when Health delivers a specific event to your Amazon Web
/// Services account. For more
/// information, see [Monitor for Health events with Amazon CloudWatch
/// Events](https://docs.aws.amazon.com/health/latest/ug/cloudwatch-events-health.html) in the
/// *Health User Guide*.
pub const EventType = struct {
    /// The actionability classification of the event. Possible values are
    /// `ACTION_REQUIRED`, `ACTION_MAY_BE_REQUIRED` and `INFORMATIONAL`. Events with
    /// `ACTION_REQUIRED` actionability require customer action to resolve or
    /// mitigate the event. Events with `ACTION_MAY_BE_REQUIRED` actionability
    /// indicates that the current status is unknown or conditional and inspection
    /// is needed to determine if action is required.
    /// Events with `INFORMATIONAL` actionability are provided for awareness and do
    /// not require immediate action.
    actionability: ?EventTypeActionability = null,

    /// A list of event type category codes. Possible values are
    /// `issue`, `accountNotification`, or `scheduledChange`. Currently,
    /// the `investigation` value isn't supported at this time.
    category: ?eventTypeCategory = null,

    /// The unique identifier for the event type. The format is
    /// `AWS_*SERVICE*_*DESCRIPTION*
    /// `; for example, `AWS_EC2_SYSTEM_MAINTENANCE_EVENT`.
    code: ?[]const u8 = null,

    /// A list of persona classifications that indicate the target audience for the
    /// event. Possible values are `OPERATIONS`, `SECURITY`, and `BILLING`. Events
    /// can be associated with multiple personas to indicate relevance to different
    /// teams or roles within an organization.
    personas: ?[]const EventTypePersona = null,

    /// The Amazon Web Services service that is affected by the event. For example,
    /// `EC2`, `RDS`.
    service: ?[]const u8 = null,

    pub const json_field_names = .{
        .actionability = "actionability",
        .category = "category",
        .code = "code",
        .personas = "personas",
        .service = "service",
    };
};
