const std = @import("std");

/// Optionally specify the amount of sharpening to apply when you use the
/// Advanced input filter. Sharpening adds contrast to the edges of your video
/// content and can reduce softness. To apply no sharpening: Keep the default
/// value, Off. To apply a minimal amount of sharpening choose Low, or for the
/// maximum choose High.
pub const AdvancedInputFilterSharpen = enum {
    off,
    low,
    high,

    pub const json_field_names = .{
        .off = "OFF",
        .low = "LOW",
        .high = "HIGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .off => "OFF",
            .low => "LOW",
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
