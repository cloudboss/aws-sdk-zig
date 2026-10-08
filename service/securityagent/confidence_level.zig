const std = @import("std");

/// Finding confidence level.
pub const ConfidenceLevel = enum {
    false_positive,
    unconfirmed,
    low,
    medium,
    high,

    pub const json_field_names = .{
        .false_positive = "FALSE_POSITIVE",
        .unconfirmed = "UNCONFIRMED",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .false_positive => "FALSE_POSITIVE",
            .unconfirmed => "UNCONFIRMED",
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
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
