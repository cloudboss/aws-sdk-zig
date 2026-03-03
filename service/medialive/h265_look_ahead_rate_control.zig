const std = @import("std");

/// H265 Look Ahead Rate Control
pub const H265LookAheadRateControl = enum {
    high,
    low,
    medium,

    pub const json_field_names = .{
        .high = "HIGH",
        .low = "LOW",
        .medium = "MEDIUM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .high => "HIGH",
            .low => "LOW",
            .medium => "MEDIUM",
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
