const LensUpgradeSummary = @import("lens_upgrade_summary.zig").LensUpgradeSummary;
const NotificationType = @import("notification_type.zig").NotificationType;

/// A notification summary return object.
pub const NotificationSummary = struct {
    /// Summary of lens upgrade.
    lens_upgrade_summary: ?LensUpgradeSummary,

    /// The type of notification.
    @"type": ?NotificationType,

    pub const json_field_names = .{
        .lens_upgrade_summary = "LensUpgradeSummary",
        .@"type" = "Type",
    };
};
