const std = @import("std");

/// The type of threshold for a notification.
pub const ThresholdType = enum {
    percentage,
    absolute_value,

    pub const json_field_names = .{
        .percentage = "PERCENTAGE",
        .absolute_value = "ABSOLUTE_VALUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .percentage => "PERCENTAGE",
            .absolute_value => "ABSOLUTE_VALUE",
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
