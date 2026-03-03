const std = @import("std");

pub const DataLakeDatasetPartitionTransformType = enum {
    year,
    month,
    day,
    hour,
    identity,

    pub const json_field_names = .{
        .year = "YEAR",
        .month = "MONTH",
        .day = "DAY",
        .hour = "HOUR",
        .identity = "IDENTITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .year => "YEAR",
            .month => "MONTH",
            .day => "DAY",
            .hour => "HOUR",
            .identity => "IDENTITY",
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
