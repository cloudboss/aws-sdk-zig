const EventTypeActionability = @import("event_type_actionability.zig").EventTypeActionability;
const eventTypeCategory = @import("event_type_category.zig").eventTypeCategory;
const EventTypePersona = @import("event_type_persona.zig").EventTypePersona;

/// The values to use to filter results from the
/// [DescribeEventTypes](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventTypes.html)
/// operation.
pub const EventTypeFilter = struct {
    /// A list of actionability values to filter event types. Possible values are
    /// `ACTION_REQUIRED`, `ACTION_MAY_BE_REQUIRED` and `INFORMATIONAL`.
    actionabilities: ?[]const EventTypeActionability = null,

    /// A list of event type category codes. Possible values are
    /// `issue`, `accountNotification`, or `scheduledChange`. Currently,
    /// the `investigation` value isn't supported at this time.
    event_type_categories: ?[]const eventTypeCategory = null,

    /// A list of event type codes.
    event_type_codes: ?[]const []const u8 = null,

    /// A list of persona classifications to filter event types. Possible values are
    /// `OPERATIONS`, `SECURITY`, and `BILLING`.
    personas: ?[]const EventTypePersona = null,

    /// The Amazon Web Services services associated with the event. For example,
    /// `EC2`, `RDS`.
    services: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .actionabilities = "actionabilities",
        .event_type_categories = "eventTypeCategories",
        .event_type_codes = "eventTypeCodes",
        .personas = "personas",
        .services = "services",
    };
};
