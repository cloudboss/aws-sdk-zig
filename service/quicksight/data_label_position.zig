const std = @import("std");

pub const DataLabelPosition = enum {
    inside,
    outside,
    left,
    top,
    bottom,
    right,

    pub const json_field_names = .{
        .inside = "INSIDE",
        .outside = "OUTSIDE",
        .left = "LEFT",
        .top = "TOP",
        .bottom = "BOTTOM",
        .right = "RIGHT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inside => "INSIDE",
            .outside => "OUTSIDE",
            .left => "LEFT",
            .top => "TOP",
            .bottom => "BOTTOM",
            .right => "RIGHT",
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
