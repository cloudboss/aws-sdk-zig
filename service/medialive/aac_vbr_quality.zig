const std = @import("std");

/// Aac Vbr Quality
pub const AacVbrQuality = enum {
    high,
    low,
    medium_high,
    medium_low,

    pub const json_field_names = .{
        .high = "HIGH",
        .low = "LOW",
        .medium_high = "MEDIUM_HIGH",
        .medium_low = "MEDIUM_LOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .high => "HIGH",
            .low => "LOW",
            .medium_high => "MEDIUM_HIGH",
            .medium_low => "MEDIUM_LOW",
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
