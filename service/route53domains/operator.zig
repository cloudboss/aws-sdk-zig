const std = @import("std");

pub const Operator = enum {
    le,
    ge,
    begins_with,

    pub const json_field_names = .{
        .le = "LE",
        .ge = "GE",
        .begins_with = "BEGINS_WITH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .le => "LE",
            .ge => "GE",
            .begins_with => "BEGINS_WITH",
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
