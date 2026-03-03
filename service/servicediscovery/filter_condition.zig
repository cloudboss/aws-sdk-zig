const std = @import("std");

pub const FilterCondition = enum {
    eq,
    in,
    between,
    begins_with,

    pub const json_field_names = .{
        .eq = "EQ",
        .in = "IN",
        .between = "BETWEEN",
        .begins_with = "BEGINS_WITH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eq => "EQ",
            .in => "IN",
            .between => "BETWEEN",
            .begins_with => "BEGINS_WITH",
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
