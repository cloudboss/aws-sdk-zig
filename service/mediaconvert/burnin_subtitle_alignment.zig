const std = @import("std");

/// Specify the alignment of your captions. If no explicit x_position is
/// provided, setting alignment to centered will placethe captions at the bottom
/// center of the output. Similarly, setting a left alignment willalign captions
/// to the bottom left of the output. If x and y positions are given in
/// conjunction with the alignment parameter, the font will be justified (either
/// left or centered) relative to those coordinates.
pub const BurninSubtitleAlignment = enum {
    centered,
    left,
    auto,

    pub const json_field_names = .{
        .centered = "CENTERED",
        .left = "LEFT",
        .auto = "AUTO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .centered => "CENTERED",
            .left => "LEFT",
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
