const std = @import("std");

/// Enumeration for query score confidence.
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
