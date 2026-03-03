const std = @import("std");

/// The operator to use in a condition that filters the results of a query for
/// Amazon Macie account quotas and usage data. Valid values are:
pub const UsageStatisticsFilterComparator = enum {
    gt,
    gte,
    lt,
    lte,
    eq,
    ne,
    contains,

    pub const json_field_names = .{
        .gt = "GT",
        .gte = "GTE",
        .lt = "LT",
        .lte = "LTE",
        .eq = "EQ",
        .ne = "NE",
        .contains = "CONTAINS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gt => "GT",
            .gte => "GTE",
            .lt => "LT",
            .lte => "LTE",
            .eq => "EQ",
            .ne => "NE",
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
