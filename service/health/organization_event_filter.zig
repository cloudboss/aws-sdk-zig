const EventActionability = @import("event_actionability.zig").EventActionability;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;
const eventStatusCode = @import("event_status_code.zig").eventStatusCode;
const eventTypeCategory = @import("event_type_category.zig").eventTypeCategory;
const EventPersona = @import("event_persona.zig").EventPersona;

/// The values to filter results from the
/// [DescribeEventsForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventsForOrganization.html) operation.
pub const OrganizationEventFilter = struct {
    /// A list of actionability values to filter events. Use this to filter events
    /// based on whether they require action (`ACTION_REQUIRED`), may require action
    /// (`ACTION_MAY_BE_REQUIRED`) or are informational (`INFORMATIONAL`).
    actionabilities: ?[]const EventActionability = null,

    /// A list of 12-digit Amazon Web Services account numbers that contains the
    /// affected entities.
    aws_account_ids: ?[]const []const u8 = null,

    end_time: ?DateTimeRange = null,

    /// A list of entity ARNs (unique identifiers).
    entity_arns: ?[]const []const u8 = null,

    /// A list of entity identifiers, such as EC2 instance IDs (i-34ab692e) or EBS
    /// volumes (vol-426ab23e).
    entity_values: ?[]const []const u8 = null,

    /// A list of event status codes.
    event_status_codes: ?[]const eventStatusCode = null,

    /// A list of event type category codes. Possible values are
    /// `issue`, `accountNotification`, or `scheduledChange`. Currently,
    /// the `investigation` value isn't supported at this time.
    event_type_categories: ?[]const eventTypeCategory = null,

    /// A list of unique identifiers for event types. For example,
    /// `"AWS_EC2_SYSTEM_MAINTENANCE_EVENT","AWS_RDS_MAINTENANCE_SCHEDULED".`
    event_type_codes: ?[]const []const u8 = null,

    last_updated_time: ?DateTimeRange = null,

    /// A list of persona values to filter events. Use this to filter events based
    /// on their target audience: `OPERATIONS`, `SECURITY`, or `BILLING`.
    personas: ?[]const EventPersona = null,

    /// A list of Amazon Web Services Regions.
    regions: ?[]const []const u8 = null,

    /// The Amazon Web Services services associated with the event. For example,
    /// `EC2`, `RDS`.
    services: ?[]const []const u8 = null,

    start_time: ?DateTimeRange = null,

    pub const json_field_names = .{
        .actionabilities = "actionabilities",
        .aws_account_ids = "awsAccountIds",
        .end_time = "endTime",
        .entity_arns = "entityArns",
        .entity_values = "entityValues",
        .event_status_codes = "eventStatusCodes",
        .event_type_categories = "eventTypeCategories",
        .event_type_codes = "eventTypeCodes",
        .last_updated_time = "lastUpdatedTime",
        .personas = "personas",
        .regions = "regions",
        .services = "services",
        .start_time = "startTime",
    };
};
