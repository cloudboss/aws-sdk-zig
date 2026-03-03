const std = @import("std");

pub const JoinType = enum {
    equijoin,
    left,
    right,
    outer,
    left_semi,
    left_anti,

    pub const json_field_names = .{
        .equijoin = "equijoin",
        .left = "left",
        .right = "right",
        .outer = "outer",
        .left_semi = "leftsemi",
        .left_anti = "leftanti",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equijoin => "equijoin",
            .left => "left",
            .right => "right",
            .outer => "outer",
            .left_semi => "leftsemi",
            .left_anti => "leftanti",
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
