/// Specifies when and how long an alarm mute rule is active.
///
/// The schedule uses either a cron expression for recurring mute windows or an
/// at expression for one-time mute windows. When the schedule activates, the
/// mute rule mutes alarm actions for the specified duration.
pub const Schedule = struct {
    /// The length of time that alarms remain muted when the schedule activates. The
    /// duration must be between 1 and 50 characters in length.
    ///
    /// Specify the duration using ISO 8601 duration format with a minimum of 1
    /// minute (`PT1M`) and maximum of 15 days (`P15D`).
    ///
    /// Examples:
    ///
    /// * `PT4H` - 4 hours for weekly system maintenance
    ///
    /// * `P2DT12H` - 2 days and 12 hours for weekend muting from Friday 6:00 PM to
    ///   Monday 6:00 AM
    ///
    /// * `PT6H` - 6 hours for monthly database maintenance
    ///
    /// * `PT2H` - 2 hours for nightly backup operations
    ///
    /// * `P7D` - 7 days for annual company shutdown
    ///
    /// The duration begins when the schedule expression time is reached. For
    /// recurring schedules, the duration applies to each occurrence.
    duration: []const u8,

    /// The schedule expression that defines when the mute rule activates. The
    /// expression must be between 1 and 256 characters in length.
    ///
    /// You can use one of two expression formats:
    ///
    /// * **Cron expressions** - For recurring mute windows. Format: `cron(Minutes
    ///   Hours Day-of-month Month Day-of-week)`
    ///
    /// Examples:
    ///
    /// * `cron(0 2 * * *)` - Activates daily at 2:00 AM
    ///
    /// * `cron(0 2 * * SUN)` - Activates every Sunday at 2:00 AM for weekly system
    ///   maintenance
    ///
    /// * `cron(0 1 1 * *)` - Activates on the first day of each month at 1:00 AM
    ///   for monthly database maintenance
    ///
    /// * `cron(0 18 * * FRI)` - Activates every Friday at 6:00 PM
    ///
    /// * `cron(0 23 * * *)` - Activates every day at 11:00 PM during nightly backup
    ///   operations
    ///
    /// The characters `*`, `-`, and `,` are supported in all fields. English names
    /// can be used for the month (JAN-DEC) and day of week (SUN-SAT) fields.
    ///
    /// * **At expressions** - For one-time mute windows. Format:
    ///   `at(yyyy-MM-ddThh:mm)`
    ///
    /// Examples:
    ///
    /// * `at(2024-05-10T14:00)` - Activates once on May 10, 2024 at 2:00 PM during
    ///   an active incident response session
    ///
    /// * `at(2024-12-23T00:00)` - Activates once on December 23, 2024 at midnight
    ///   during annual company shutdown
    expression: []const u8,

    /// The time zone to use when evaluating the schedule expression. The time zone
    /// must be between 1 and 50 characters in length.
    ///
    /// Specify the time zone using standard timezone identifiers (for example,
    /// `America/New_York`, `Europe/London`, or `Asia/Tokyo`).
    ///
    /// If you don't specify a time zone, UTC is used by default. The time zone
    /// affects how cron and at expressions are interpreted, as well as start and
    /// expire dates you specify
    ///
    /// Examples:
    ///
    /// * `America/New_York` - Eastern Time (US)
    ///
    /// * `America/Los_Angeles` - Pacific Time (US)
    ///
    /// * `Europe/London` - British Time
    ///
    /// * `Asia/Tokyo` - Japan Standard Time
    ///
    /// * `UTC` - Coordinated Universal Time
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .duration = "Duration",
        .expression = "Expression",
        .timezone = "Timezone",
    };
};
