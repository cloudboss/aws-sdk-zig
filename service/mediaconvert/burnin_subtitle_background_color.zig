const std = @import("std");

/// Specify the color of the rectangle behind the captions. Leave background
/// color blank and set Style passthrough to enabled to use the background color
/// data from your input captions, if present.
pub const BurninSubtitleBackgroundColor = enum {
    none,
    black,
    white,
    auto,

    pub const json_field_names = .{
        .none = "NONE",
        .black = "BLACK",
        .white = "WHITE",
        .auto = "AUTO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .black => "BLACK",
            .white => "WHITE",
            .auto => "AUTO",
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
