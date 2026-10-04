const std = @import("std");

/// The priority level that can be set when creating a customer notification.
/// Valid values are HIGH and LOW. URGENT priority is reserved for
/// system-generated notifications.
pub const ConfigurableNotificationPriority = enum {
    high,
    low,

    pub const json_field_names = .{
        .high = "HIGH",
        .low = "LOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .high => "HIGH",
            .low => "LOW",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
