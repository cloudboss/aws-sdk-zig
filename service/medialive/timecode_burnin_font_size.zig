const std = @import("std");

/// Timecode Burnin Font Size
pub const TimecodeBurninFontSize = enum {
    extra_small_10,
    large_48,
    medium_32,
    small_16,

    pub const json_field_names = .{
        .extra_small_10 = "EXTRA_SMALL_10",
        .large_48 = "LARGE_48",
        .medium_32 = "MEDIUM_32",
        .small_16 = "SMALL_16",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .extra_small_10 => "EXTRA_SMALL_10",
            .large_48 => "LARGE_48",
            .medium_32 => "MEDIUM_32",
            .small_16 => "SMALL_16",
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
