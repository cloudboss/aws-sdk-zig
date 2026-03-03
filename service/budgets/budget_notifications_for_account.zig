const Notification = @import("notification.zig").Notification;

/// The budget name and associated notifications for an account.
pub const BudgetNotificationsForAccount = struct {
    budget_name: ?[]const u8 = null,

    notifications: ?[]const Notification = null,

    pub const json_field_names = .{
        .budget_name = "BudgetName",
        .notifications = "Notifications",
    };
};
