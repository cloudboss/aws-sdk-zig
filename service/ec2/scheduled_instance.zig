const ScheduledInstanceRecurrence = @import("scheduled_instance_recurrence.zig").ScheduledInstanceRecurrence;

/// Describes a Scheduled Instance.
pub const ScheduledInstance = struct {
    /// The Availability Zone.
    availability_zone: ?[]const u8 = null,

    /// The date when the Scheduled Instance was purchased.
    create_date: ?i64 = null,

    /// The hourly price for a single instance.
    hourly_price: ?[]const u8 = null,

    /// The number of instances.
    instance_count: ?i32 = null,

    /// The instance type.
    instance_type: ?[]const u8 = null,

    /// The network platform.
    network_platform: ?[]const u8 = null,

    /// The time for the next schedule to start.
    next_slot_start_time: ?i64 = null,

    /// The platform (`Linux/UNIX` or `Windows`).
    platform: ?[]const u8 = null,

    /// The time that the previous schedule ended or will end.
    previous_slot_end_time: ?i64 = null,

    /// The schedule recurrence.
    recurrence: ?ScheduledInstanceRecurrence = null,

    /// The Scheduled Instance ID.
    scheduled_instance_id: ?[]const u8 = null,

    /// The number of hours in the schedule.
    slot_duration_in_hours: ?i32 = null,

    /// The end date for the Scheduled Instance.
    term_end_date: ?i64 = null,

    /// The start date for the Scheduled Instance.
    term_start_date: ?i64 = null,

    /// The total number of hours for a single instance for the entire term.
    total_scheduled_instance_hours: ?i32 = null,
};
