const ScalingActivityStatusCode = @import("scaling_activity_status_code.zig").ScalingActivityStatusCode;

/// Describes scaling activity, which is a long-running process that represents
/// a change
/// to your Auto Scaling group, such as changing its size or replacing an
/// instance.
pub const Activity = struct {
    /// The ID of the activity.
    activity_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Auto Scaling group.
    auto_scaling_group_arn: ?[]const u8,

    /// The name of the Auto Scaling group.
    auto_scaling_group_name: []const u8,

    /// The state of the Auto Scaling group, which is either `InService` or
    /// `Deleted`.
    auto_scaling_group_state: ?[]const u8,

    /// The reason the activity began.
    cause: []const u8,

    /// A friendly, more verbose description of the activity.
    description: ?[]const u8,

    /// The details about the activity.
    details: ?[]const u8,

    /// The end time of the activity.
    end_time: ?i64,

    /// A value between 0 and 100 that indicates the progress of the activity.
    progress: ?i32,

    /// The start time of the activity.
    start_time: i64,

    /// The current status of the activity.
    status_code: ScalingActivityStatusCode,

    /// A friendly, more verbose description of the activity status.
    status_message: ?[]const u8,
};
