const NotificationResource = @import("notification_resource.zig").NotificationResource;
const NotificationRole = @import("notification_role.zig").NotificationRole;

/// The topic of the notification.
pub const Topic = struct {
    resource: NotificationResource,

    /// The role of the resource mentioned in a notification.
    role: NotificationRole,

    /// The subject of the resource mentioned in a notification.
    subject: []const u8,

    pub const json_field_names = .{
        .resource = "resource",
        .role = "role",
        .subject = "subject",
    };
};
