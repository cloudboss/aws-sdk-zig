const std = @import("std");

/// Specify whether the text spacing in your captions is set by the captions
/// grid, or varies depending on letter width. Choose fixed grid to conform to
/// the spacing specified in the captions file more accurately. Choose
/// proportional to make the text easier to read for closed captions.
pub const BurninSubtitleTeletextSpacing = enum {
    fixed_grid,
    proportional,
    auto,

    pub const json_field_names = .{
        .fixed_grid = "FIXED_GRID",
        .proportional = "PROPORTIONAL",
        .auto = "AUTO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fixed_grid => "FIXED_GRID",
            .proportional => "PROPORTIONAL",
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
