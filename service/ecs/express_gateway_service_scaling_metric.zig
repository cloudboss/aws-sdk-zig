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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
