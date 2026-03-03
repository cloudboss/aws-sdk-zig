const std = @import("std");

pub const MessageType = enum {
    configuration_item_change_notification,
    configuration_snapshot_delivery_completed,
    scheduled_notification,
    oversized_configuration_item_change_notification,

    pub const json_field_names = .{
        .configuration_item_change_notification = "ConfigurationItemChangeNotification",
        .configuration_snapshot_delivery_completed = "ConfigurationSnapshotDeliveryCompleted",
        .scheduled_notification = "ScheduledNotification",
        .oversized_configuration_item_change_notification = "OversizedConfigurationItemChangeNotification",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .configuration_item_change_notification => "ConfigurationItemChangeNotification",
            .configuration_snapshot_delivery_completed => "ConfigurationSnapshotDeliveryCompleted",
            .scheduled_notification => "ScheduledNotification",
            .oversized_configuration_item_change_notification => "OversizedConfigurationItemChangeNotification",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
