const std = @import("std");

/// The priority level of a notification. Valid values are URGENT (reserved for
/// system-generated notifications during availability or security events),
/// HIGH, and LOW. High priority notifications are displayed above low priority
/// notifications in the notification widget.
pub const NotificationPriority = enum {
    urgent,
    high,
    low,

    pub const json_field_names = .{
        .urgent = "URGENT",
        .high = "HIGH",
        .low = "LOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .urgent => "URGENT",
            .high => "HIGH",
            .low => "LOW",
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
