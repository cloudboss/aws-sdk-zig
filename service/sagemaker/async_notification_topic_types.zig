const std = @import("std");

pub const AsyncNotificationTopicTypes = enum {
    success_notification_topic,
    error_notification_topic,

    pub const json_field_names = .{
        .success_notification_topic = "SUCCESS_NOTIFICATION_TOPIC",
        .error_notification_topic = "ERROR_NOTIFICATION_TOPIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success_notification_topic => "SUCCESS_NOTIFICATION_TOPIC",
            .error_notification_topic => "ERROR_NOTIFICATION_TOPIC",
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
