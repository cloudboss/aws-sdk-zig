const std = @import("std");

pub const ExpressGatewayServiceScalingMetric = enum {
    average_cpu_utilization,
    average_memory_utilization,
    request_count_per_target,

    pub const json_field_names = .{
        .average_cpu_utilization = "AVERAGE_CPU",
        .average_memory_utilization = "AVERAGE_MEMORY",
        .request_count_per_target = "REQUEST_COUNT_PER_TARGET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .average_cpu_utilization => "AVERAGE_CPU",
            .average_memory_utilization => "AVERAGE_MEMORY",
            .request_count_per_target => "REQUEST_COUNT_PER_TARGET",
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
