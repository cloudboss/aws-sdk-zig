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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
