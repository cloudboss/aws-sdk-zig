const ActivityReward = @import("activity_reward.zig").ActivityReward;
const ActivityStatus = @import("activity_status.zig").ActivityStatus;

/// The summary of activities.
pub const ActivitySummary = struct {
    /// A unique identifier that identifies the activity.
    activity_id: []const u8,

    /// The reward for the activity.
    reward: ActivityReward,

    /// The current status of the activity.
    status: ActivityStatus,

    /// The title of the activity.
    title: []const u8,

    pub const json_field_names = .{
        .activity_id = "activityId",
        .reward = "reward",
        .status = "status",
        .title = "title",
    };
};
