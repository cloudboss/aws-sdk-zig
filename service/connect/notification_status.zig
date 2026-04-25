const std = @import("std");

/// The status of a notification for a specific user. Valid values are READ,
/// UNREAD, and HIDDEN (removes the notification from the widget).
pub const NotificationStatus = enum {
    read,
    unread,
    hidden,

    pub const json_field_names = .{
        .read = "READ",
        .unread = "UNREAD",
        .hidden = "HIDDEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .read => "READ",
            .unread => "UNREAD",
            .hidden => "HIDDEN",
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
