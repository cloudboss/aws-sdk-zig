const ActivityType = @import("activity_type.zig").ActivityType;
const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

/// Detailed information about an activity type.
pub const ActivityTypeInfo = struct {
    /// The ActivityType type structure representing the activity type.
    activity_type: ActivityType,

    /// The date and time this activity type was created through
    /// RegisterActivityType.
    creation_date: i64,

    /// If DEPRECATED, the date and time DeprecateActivityType was called.
    deprecation_date: ?i64 = null,

    /// The description of the activity type provided in RegisterActivityType.
    description: ?[]const u8 = null,

    /// The current status of the activity type.
    status: RegistrationStatus,

    pub const json_field_names = .{
        .activity_type = "activityType",
        .creation_date = "creationDate",
        .deprecation_date = "deprecationDate",
        .description = "description",
        .status = "status",
    };
};
