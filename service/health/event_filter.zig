const aws = @import("aws");

const EventActionability = @import("event_actionability.zig").EventActionability;
const DateTimeRange = @import("date_time_range.zig").DateTimeRange;
const eventStatusCode = @import("event_status_code.zig").eventStatusCode;
const eventTypeCategory = @import("event_type_category.zig").eventTypeCategory;
const EventPersona = @import("event_persona.zig").EventPersona;

/// The values to use to filter results from the
/// [DescribeEvents](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEvents.html) and
/// [DescribeEventAggregates](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventAggregates.html) operations.
pub const EventFilter = struct {
    /// A list of actionability values to filter events. Use this to filter events
    /// based on whether they require action (`ACTION_REQUIRED`), may require action
    /// (`ACTION_MAY_BE_REQUIRED`) or are informational (`INFORMATIONAL`).
    actionabilities: ?[]const EventActionability = null,

    /// A list of Amazon Web Services Availability Zones.
    availability_zones: ?[]const []const u8 = null,

    /// A list of dates and times that the event ended.
    end_times: ?[]const DateTimeRange = null,

    /// A list of entity ARNs (unique identifiers).
    entity_arns: ?[]const []const u8 = null,

    /// A list of entity identifiers, such as EC2 instance IDs (`i-34ab692e`) or EBS
    /// volumes (`vol-426ab23e`).
    entity_values: ?[]const []const u8 = null,

    /// A list of event ARNs (unique identifiers). For example:
    /// `"arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-CDE456", "arn:aws:health:us-west-1::event/EBS/AWS_EBS_LOST_VOLUME/AWS_EBS_LOST_VOLUME_CHI789_JKL101"`
    event_arns: ?[]const []const u8 = null,

    /// A list of event status codes.
    event_status_codes: ?[]const eventStatusCode = null,

    /// A list of event type category codes. Possible values are
    /// `issue`, `accountNotification`, or `scheduledChange`. Currently,
    /// the `investigation` value isn't supported at this time.
    event_type_categories: ?[]const eventTypeCategory = null,

    /// A list of unique identifiers for event types. For example,
    /// `"AWS_EC2_SYSTEM_MAINTENANCE_EVENT","AWS_RDS_MAINTENANCE_SCHEDULED".`
    event_type_codes: ?[]const []const u8 = null,

    /// A list of dates and times that the event was last updated.
    last_updated_times: ?[]const DateTimeRange = null,

    /// A list of persona values to filter events. Use this to filter events based
    /// on their target audience: `OPERATIONS`, `SECURITY`, or `BILLING`.
    personas: ?[]const EventPersona = null,

    /// A list of Amazon Web Services Regions.
    regions: ?[]const []const u8 = null,

    /// The Amazon Web Services services associated with the event. For example,
    /// `EC2`, `RDS`.
    services: ?[]const []const u8 = null,

    /// A list of dates and times that the event began.
    start_times: ?[]const DateTimeRange = null,

    /// A map of entity tags attached to the affected entity.
    ///
    /// Currently, the `tags` property isn't supported.
    tags: ?[]const []const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .actionabilities = "actionabilities",
        .availability_zones = "availabilityZones",
        .end_times = "endTimes",
        .entity_arns = "entityArns",
        .entity_values = "entityValues",
        .event_arns = "eventArns",
        .event_status_codes = "eventStatusCodes",
        .event_type_categories = "eventTypeCategories",
        .event_type_codes = "eventTypeCodes",
        .last_updated_times = "lastUpdatedTimes",
        .personas = "personas",
        .regions = "regions",
        .services = "services",
        .start_times = "startTimes",
        .tags = "tags",
    };
};
