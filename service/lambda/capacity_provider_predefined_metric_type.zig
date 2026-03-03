const std = @import("std");

pub const CapacityProviderPredefinedMetricType = enum {
    lambda_capacity_provider_average_cpu_utilization,

    pub const json_field_names = .{
        .lambda_capacity_provider_average_cpu_utilization = "LambdaCapacityProviderAverageCPUUtilization",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lambda_capacity_provider_average_cpu_utilization => "LambdaCapacityProviderAverageCPUUtilization",
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
