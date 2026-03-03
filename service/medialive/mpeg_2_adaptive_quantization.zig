const std = @import("std");

/// Mpeg2 Adaptive Quantization
pub const Mpeg2AdaptiveQuantization = enum {
    auto,
    high,
    low,
    medium,
    off,

    pub const json_field_names = .{
        .auto = "AUTO",
        .high = "HIGH",
        .low = "LOW",
        .medium = "MEDIUM",
        .off = "OFF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .high => "HIGH",
            .low => "LOW",
            .medium => "MEDIUM",
            .off => "OFF",
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
