const std = @import("std");

pub const ScoreConfidence = enum {
    very_high,
    high,
    medium,
    low,
    not_available,

    pub const json_field_names = .{
        .very_high = "VERY_HIGH",
        .high = "HIGH",
        .medium = "MEDIUM",
        .low = "LOW",
        .not_available = "NOT_AVAILABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .very_high => "VERY_HIGH",
            .high => "HIGH",
            .medium => "MEDIUM",
            .low => "LOW",
            .not_available => "NOT_AVAILABLE",
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
