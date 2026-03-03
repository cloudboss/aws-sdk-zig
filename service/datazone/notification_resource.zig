const NotificationResourceType = @import("notification_resource_type.zig").NotificationResourceType;

/// The details of the resource mentioned in a notification.
pub const NotificationResource = struct {
    /// The ID of the resource mentioned in a notification.
    id: []const u8,

    /// The name of the resource mentioned in a notification.
    name: ?[]const u8 = null,

    /// The type of the resource mentioned in a notification.
    @"type": NotificationResourceType,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .@"type" = "type",
    };
};
