const std = @import("std");

pub const CustomizableMetricHeadroom = enum {
    percent_30,
    percent_20,
    percent_10,
    percent_0,

    pub const json_field_names = .{
        .percent_30 = "PERCENT_30",
        .percent_20 = "PERCENT_20",
        .percent_10 = "PERCENT_10",
        .percent_0 = "PERCENT_0",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .percent_30 => "PERCENT_30",
            .percent_20 => "PERCENT_20",
            .percent_10 => "PERCENT_10",
            .percent_0 => "PERCENT_0",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
