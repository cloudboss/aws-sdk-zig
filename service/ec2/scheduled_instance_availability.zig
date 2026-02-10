const ScheduledInstanceRecurrence = @import("scheduled_instance_recurrence.zig").ScheduledInstanceRecurrence;

/// Describes a schedule that is available for your Scheduled Instances.
pub const ScheduledInstanceAvailability = struct {
    /// The Availability Zone.
    availability_zone: ?[]const u8,

    /// The number of available instances.
    available_instance_count: ?i32,

    /// The time period for the first schedule to start.
    first_slot_start_time: ?i64,

    /// The hourly price for a single instance.
    hourly_price: ?[]const u8,

    /// The instance type. You can specify one of the C3, C4, M4, or R3 instance
    /// types.
    instance_type: ?[]const u8,

    /// The maximum term. The only possible value is 365 days.
    max_term_duration_in_days: ?i32,

    /// The minimum term. The only possible value is 365 days.
    min_term_duration_in_days: ?i32,

    /// The network platform.
    network_platform: ?[]const u8,

    /// The platform (`Linux/UNIX` or `Windows`).
    platform: ?[]const u8,

    /// The purchase token. This token expires in two hours.
    purchase_token: ?[]const u8,

    /// The schedule recurrence.
    recurrence: ?ScheduledInstanceRecurrence,

    /// The number of hours in the schedule.
    slot_duration_in_hours: ?i32,

    /// The total number of hours for a single instance for the entire term.
    total_scheduled_instance_hours: ?i32,
};
