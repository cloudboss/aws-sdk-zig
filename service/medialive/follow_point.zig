const std = @import("std");

/// Follow reference point.
pub const FollowPoint = enum {
    end,
    start,

    pub const json_field_names = .{
        .end = "END",
        .start = "START",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .end => "END",
            .start => "START",
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
