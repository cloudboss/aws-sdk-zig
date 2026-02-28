const ProfileNotificationType = @import("profile_notification_type.zig").ProfileNotificationType;

/// The profile notification summary.
pub const ProfileNotificationSummary = struct {
    /// The current profile version.
    current_profile_version: ?[]const u8,

    /// The latest profile version.
    latest_profile_version: ?[]const u8,

    /// The profile ARN.
    profile_arn: ?[]const u8,

    /// The profile name.
    profile_name: ?[]const u8,

    /// Type of notification.
    @"type": ?ProfileNotificationType,

    workload_id: ?[]const u8,

    workload_name: ?[]const u8,

    pub const json_field_names = .{
        .current_profile_version = "CurrentProfileVersion",
        .latest_profile_version = "LatestProfileVersion",
        .profile_arn = "ProfileArn",
        .profile_name = "ProfileName",
        .@"type" = "Type",
        .workload_id = "WorkloadId",
        .workload_name = "WorkloadName",
    };
};
