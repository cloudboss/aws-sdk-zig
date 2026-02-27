const EventActionability = @import("event_actionability.zig").EventActionability;
const eventScopeCode = @import("event_scope_code.zig").eventScopeCode;
const eventTypeCategory = @import("event_type_category.zig").eventTypeCategory;
const EventPersona = @import("event_persona.zig").EventPersona;
const eventStatusCode = @import("event_status_code.zig").eventStatusCode;

/// Summary information about an event, returned by the
/// [DescribeEventsForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventsForOrganization.html) operation.
pub const OrganizationEvent = struct {
    /// The actionability classification of the event. Possible values are
    /// `ACTION_REQUIRED`, `ACTION_MAY_BE_REQUIRED` and `INFORMATIONAL`. Events with
    /// `ACTION_REQUIRED` actionability require customer action to resolve or
    /// mitigate the event. Events with `ACTION_MAY_BE_REQUIRED` actionability
    /// indicates that the current status is unknown or conditional and inspection
    /// is needed to determine if action is required.
    /// Events with `INFORMATIONAL` actionability are provided for awareness and do
    /// not require immediate action.
    actionability: ?EventActionability,

    /// The unique identifier for the event. The event ARN has the
    /// `arn:aws:health:*event-region*::event/*SERVICE*/*EVENT_TYPE_CODE*/*EVENT_TYPE_PLUS_ID*
    /// `
    /// format.
    ///
    /// For example, an event ARN might look like the following:
    ///
    /// `arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-DEF456`
    arn: ?[]const u8,

    /// The date and time that the event ended.
    end_time: ?i64,

    /// This parameter specifies if the Health event is a public Amazon Web Services
    /// service event or an account-specific event.
    ///
    /// * If the `eventScopeCode` value is `PUBLIC`, then the
    /// `affectedAccounts` value is always empty.
    ///
    /// * If the `eventScopeCode` value is `ACCOUNT_SPECIFIC`, then
    /// the `affectedAccounts` value lists the affected Amazon Web Services accounts
    /// in your
    /// organization. For example, if an event affects a service such as Amazon
    /// Elastic Compute Cloud and you
    /// have Amazon Web Services accounts that use that service, those account IDs
    /// appear in the
    /// response.
    ///
    /// * If the `eventScopeCode` value is `NONE`, then the
    /// `eventArn` that you specified in the request is invalid or doesn't
    /// exist.
    event_scope_code: ?eventScopeCode,

    /// A list of event type category codes. Possible values are
    /// `issue`, `accountNotification`, or `scheduledChange`. Currently,
    /// the `investigation` value isn't supported at this time.
    event_type_category: ?eventTypeCategory,

    /// The unique identifier for the event type. The format is
    /// `AWS_SERVICE_DESCRIPTION`. For example,
    /// `AWS_EC2_SYSTEM_MAINTENANCE_EVENT`.
    event_type_code: ?[]const u8,

    /// The most recent date and time that the event was updated.
    last_updated_time: ?i64,

    /// A list of persona classifications that indicate the target audience for the
    /// event. Possible values are `OPERATIONS`, `SECURITY`, and `BILLING`. Events
    /// can be associated with multiple personas to indicate relevance to different
    /// teams or roles within an organization.
    personas: ?[]const EventPersona,

    /// The Amazon Web Services Region name of the event.
    region: ?[]const u8,

    /// The Amazon Web Services service that is affected by the event, such as EC2
    /// and RDS.
    service: ?[]const u8,

    /// The date and time that the event began.
    start_time: ?i64,

    /// The most recent status of the event. Possible values are `open`,
    /// `closed`, and `upcoming`.
    status_code: ?eventStatusCode,

    pub const json_field_names = .{
        .actionability = "actionability",
        .arn = "arn",
        .end_time = "endTime",
        .event_scope_code = "eventScopeCode",
        .event_type_category = "eventTypeCategory",
        .event_type_code = "eventTypeCode",
        .last_updated_time = "lastUpdatedTime",
        .personas = "personas",
        .region = "region",
        .service = "service",
        .start_time = "startTime",
        .status_code = "statusCode",
    };
};
