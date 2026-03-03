const std = @import("std");

pub const LoadMetricType = enum {
    asg_total_cpu_utilization,
    asg_total_network_in,
    asg_total_network_out,
    alb_target_group_request_count,

    pub const json_field_names = .{
        .asg_total_cpu_utilization = "ASGTotalCPUUtilization",
        .asg_total_network_in = "ASGTotalNetworkIn",
        .asg_total_network_out = "ASGTotalNetworkOut",
        .alb_target_group_request_count = "ALBTargetGroupRequestCount",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .asg_total_cpu_utilization => "ASGTotalCPUUtilization",
            .asg_total_network_in => "ASGTotalNetworkIn",
            .asg_total_network_out => "ASGTotalNetworkOut",
            .alb_target_group_request_count => "ALBTargetGroupRequestCount",
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
