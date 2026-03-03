const std = @import("std");

/// The operator to use in a condition. Depending on the type of condition,
/// possible values are:
pub const JobComparator = enum {
    eq,
    gt,
    gte,
    lt,
    lte,
    ne,
    contains,
    starts_with,

    pub const json_field_names = .{
        .eq = "EQ",
        .gt = "GT",
        .gte = "GTE",
        .lt = "LT",
        .lte = "LTE",
        .ne = "NE",
        .contains = "CONTAINS",
        .starts_with = "STARTS_WITH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eq => "EQ",
            .gt => "GT",
            .gte => "GTE",
            .lt => "LT",
            .lte => "LTE",
            .ne => "NE",
            .contains => "CONTAINS",
            .starts_with => "STARTS_WITH",
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
