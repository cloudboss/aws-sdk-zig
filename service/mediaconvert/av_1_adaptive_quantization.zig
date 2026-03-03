const std = @import("std");

/// Specify the strength of any adaptive quantization filters that you enable.
/// The value that you choose here applies to Spatial adaptive quantization.
pub const Av1AdaptiveQuantization = enum {
    off,
    low,
    medium,
    high,
    higher,
    max,

    pub const json_field_names = .{
        .off = "OFF",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .higher = "HIGHER",
        .max = "MAX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .off => "OFF",
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
            .higher => "HIGHER",
            .max => "MAX",
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
