const std = @import("std");

pub const AnalyticsFilterOperator = enum {
    equals,
    greater_than,
    less_than,

    pub const json_field_names = .{
        .equals = "EQ",
        .greater_than = "GT",
        .less_than = "LT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQ",
            .greater_than => "GT",
            .less_than => "LT",
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
