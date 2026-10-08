const std = @import("std");

pub const AccountColor = enum {
    none,
    pink,
    purple,
    darkblue,
    lightblue,
    teal,
    green,
    yellow,
    orange,
    red,

    pub const json_field_names = .{
        .none = "none",
        .pink = "pink",
        .purple = "purple",
        .darkblue = "darkBlue",
        .lightblue = "lightBlue",
        .teal = "teal",
        .green = "green",
        .yellow = "yellow",
        .orange = "orange",
        .red = "red",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "none",
            .pink => "pink",
            .purple => "purple",
            .darkblue => "darkBlue",
            .lightblue => "lightBlue",
            .teal => "teal",
            .green => "green",
            .yellow => "yellow",
            .orange => "orange",
            .red => "red",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
