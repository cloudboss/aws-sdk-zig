const RecurrenceSettings = @import("recurrence_settings.zig").RecurrenceSettings;

/// Information about a rotation in an on-call schedule.
pub const Rotation = struct {
    /// The Amazon Resource Names (ARNs) of the contacts assigned to the rotation
    /// team.
    contact_ids: ?[]const []const u8,

    /// The name of the rotation.
    name: []const u8,

    /// Information about when an on-call rotation is in effect and how long the
    /// rotation period
    /// lasts.
    recurrence: ?RecurrenceSettings,

    /// The Amazon Resource Name (ARN) of the rotation.
    rotation_arn: []const u8,

    /// The date and time the rotation becomes active.
    start_time: ?i64,

    /// The time zone the rotation’s activity is based on, in Internet Assigned
    /// Numbers
    /// Authority (IANA) format. For example: "America/Los_Angeles", "UTC", or
    /// "Asia/Seoul".
    time_zone_id: ?[]const u8,

    pub const json_field_names = .{
        .contact_ids = "ContactIds",
        .name = "Name",
        .recurrence = "Recurrence",
        .rotation_arn = "RotationArn",
        .start_time = "StartTime",
        .time_zone_id = "TimeZoneId",
    };
};
