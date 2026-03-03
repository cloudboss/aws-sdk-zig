const std = @import("std");

pub const MetricType = enum {
    asg_average_cpu_utilization,
    asg_average_network_in,
    asg_average_network_out,
    alb_request_count_per_target,

    pub const json_field_names = .{
        .asg_average_cpu_utilization = "ASGAverageCPUUtilization",
        .asg_average_network_in = "ASGAverageNetworkIn",
        .asg_average_network_out = "ASGAverageNetworkOut",
        .alb_request_count_per_target = "ALBRequestCountPerTarget",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .asg_average_cpu_utilization => "ASGAverageCPUUtilization",
            .asg_average_network_in => "ASGAverageNetworkIn",
            .asg_average_network_out => "ASGAverageNetworkOut",
            .alb_request_count_per_target => "ALBRequestCountPerTarget",
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
