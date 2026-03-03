const std = @import("std");

/// The grouping to sort the results by. Valid values are:
pub const FindingStatisticsSortAttributeName = enum {
    group_key,
    count,

    pub const json_field_names = .{
        .group_key = "groupKey",
        .count = "count",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .group_key => "groupKey",
            .count => "count",
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
