const std = @import("std");

pub const CustomizableMetricThreshold = enum {
    p90,
    p95,
    p99_5,

    pub const json_field_names = .{
        .p90 = "P90",
        .p95 = "P95",
        .p99_5 = "P99_5",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .p90 => "P90",
            .p95 => "P95",
            .p99_5 => "P99_5",
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
