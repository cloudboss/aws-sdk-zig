const std = @import("std");

pub const MetricType = enum {
    /// Metric value aggregated for all instances of a frame name in a profile
    /// relative to the root frame.
    aggregated_relative_total_time,

    pub const json_field_names = .{
        .aggregated_relative_total_time = "AggregatedRelativeTotalTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aggregated_relative_total_time => "AggregatedRelativeTotalTime",
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
