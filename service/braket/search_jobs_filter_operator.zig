const std = @import("std");

pub const SearchJobsFilterOperator = enum {
    lt,
    lte,
    equal,
    gt,
    gte,
    between,
    contains,

    pub const json_field_names = .{
        .lt = "LT",
        .lte = "LTE",
        .equal = "EQUAL",
        .gt = "GT",
        .gte = "GTE",
        .between = "BETWEEN",
        .contains = "CONTAINS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lt => "LT",
            .lte => "LTE",
            .equal => "EQUAL",
            .gt => "GT",
            .gte => "GTE",
            .between => "BETWEEN",
            .contains => "CONTAINS",
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
