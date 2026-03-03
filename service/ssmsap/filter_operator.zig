const std = @import("std");

pub const FilterOperator = enum {
    equals,
    greater_than_or_equals,
    less_than_or_equals,

    pub const json_field_names = .{
        .equals = "Equals",
        .greater_than_or_equals = "GreaterThanOrEquals",
        .less_than_or_equals = "LessThanOrEquals",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "Equals",
            .greater_than_or_equals => "GreaterThanOrEquals",
            .less_than_or_equals => "LessThanOrEquals",
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
