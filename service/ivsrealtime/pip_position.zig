const std = @import("std");

pub const PipPosition = enum {
    top_left,
    top_right,
    bottom_left,
    bottom_right,

    pub const json_field_names = .{
        .top_left = "TOP_LEFT",
        .top_right = "TOP_RIGHT",
        .bottom_left = "BOTTOM_LEFT",
        .bottom_right = "BOTTOM_RIGHT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .top_left => "TOP_LEFT",
            .top_right => "TOP_RIGHT",
            .bottom_left => "BOTTOM_LEFT",
            .bottom_right => "BOTTOM_RIGHT",
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
