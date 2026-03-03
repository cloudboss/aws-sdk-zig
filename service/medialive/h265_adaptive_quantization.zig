const std = @import("std");

/// H265 Adaptive Quantization
pub const H265AdaptiveQuantization = enum {
    auto,
    high,
    higher,
    low,
    max,
    medium,
    off,

    pub const json_field_names = .{
        .auto = "AUTO",
        .high = "HIGH",
        .higher = "HIGHER",
        .low = "LOW",
        .max = "MAX",
        .medium = "MEDIUM",
        .off = "OFF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .high => "HIGH",
            .higher => "HIGHER",
            .low => "LOW",
            .max => "MAX",
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
