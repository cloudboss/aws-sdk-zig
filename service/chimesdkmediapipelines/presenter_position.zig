const std = @import("std");

pub const PresenterPosition = enum {
    top_left,
    top_right,
    bottom_left,
    bottom_right,

    pub const json_field_names = .{
        .top_left = "TopLeft",
        .top_right = "TopRight",
        .bottom_left = "BottomLeft",
        .bottom_right = "BottomRight",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .top_left => "TopLeft",
            .top_right => "TopRight",
            .bottom_left => "BottomLeft",
            .bottom_right => "BottomRight",
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
