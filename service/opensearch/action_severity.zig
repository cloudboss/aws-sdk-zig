const std = @import("std");

pub const ActionSeverity = enum {
    high,
    medium,
    low,

    pub const json_field_names = .{
        .high = "HIGH",
        .medium = "MEDIUM",
        .low = "LOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .high => "HIGH",
            .medium => "MEDIUM",
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
