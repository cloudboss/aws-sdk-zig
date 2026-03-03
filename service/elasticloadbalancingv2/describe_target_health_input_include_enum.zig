const std = @import("std");

pub const DescribeTargetHealthInputIncludeEnum = enum {
    anomaly,
    all,

    pub const json_field_names = .{
        .anomaly = "AnomalyDetection",
        .all = "All",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .anomaly => "AnomalyDetection",
            .all => "All",
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
