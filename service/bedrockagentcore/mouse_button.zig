const std = @import("std");

/// The mouse button to use for a browser mouse action.
pub const MouseButton = enum {
    left,
    right,
    middle,

    pub const json_field_names = .{
        .left = "LEFT",
        .right = "RIGHT",
        .middle = "MIDDLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .left => "LEFT",
            .right => "RIGHT",
            .middle => "MIDDLE",
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
