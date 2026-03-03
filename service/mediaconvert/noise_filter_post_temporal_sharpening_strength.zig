const std = @import("std");

/// Use Post temporal sharpening strength to define the amount of sharpening the
/// transcoder applies to your output. Set Post temporal sharpening strength to
/// Low, Medium, or High to indicate the amount of sharpening.
pub const NoiseFilterPostTemporalSharpeningStrength = enum {
    low,
    medium,
    high,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
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
