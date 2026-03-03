const std = @import("std");

/// Specify the Unit type to use when you enter a value for X position, Y
/// position, Width, or Height. You can choose Pixels or Percentage. Leave blank
/// to use the default value, Pixels.
pub const VideoOverlayUnit = enum {
    pixels,
    percentage,

    pub const json_field_names = .{
        .pixels = "PIXELS",
        .percentage = "PERCENTAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pixels => "PIXELS",
            .percentage => "PERCENTAGE",
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
