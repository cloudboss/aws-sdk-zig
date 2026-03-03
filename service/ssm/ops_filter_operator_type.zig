const std = @import("std");

pub const OpsFilterOperatorType = enum {
    equal,
    not_equal,
    begin_with,
    less_than,
    greater_than,
    exists,

    pub const json_field_names = .{
        .equal = "Equal",
        .not_equal = "NotEqual",
        .begin_with = "BeginWith",
        .less_than = "LessThan",
        .greater_than = "GreaterThan",
        .exists = "Exists",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equal => "Equal",
            .not_equal => "NotEqual",
            .begin_with => "BeginWith",
            .less_than => "LessThan",
            .greater_than => "GreaterThan",
            .exists => "Exists",
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
