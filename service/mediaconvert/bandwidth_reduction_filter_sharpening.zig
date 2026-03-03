const std = @import("std");

/// Optionally specify the level of sharpening to apply when you use the
/// Bandwidth reduction filter. Sharpening adds contrast to the edges of your
/// video content and can reduce softness. Keep the default value Off to apply
/// no sharpening. Set Sharpening strength to Low to apply a minimal amount of
/// sharpening, or High to apply a maximum amount of sharpening.
pub const BandwidthReductionFilterSharpening = enum {
    low,
    medium,
    high,
    off,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .off = "OFF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
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
