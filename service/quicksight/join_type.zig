const std = @import("std");

pub const JoinType = enum {
    inner,
    outer,
    left,
    right,

    pub const json_field_names = .{
        .inner = "INNER",
        .outer = "OUTER",
        .left = "LEFT",
        .right = "RIGHT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inner => "INNER",
            .outer => "OUTER",
            .left => "LEFT",
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
