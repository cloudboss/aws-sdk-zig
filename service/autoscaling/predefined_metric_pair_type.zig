const std = @import("std");

pub const PredefinedMetricPairType = enum {
    asgcpu_utilization,
    asg_network_in,
    asg_network_out,
    alb_request_count,

    pub const json_field_names = .{
        .asgcpu_utilization = "ASGCPUUtilization",
        .asg_network_in = "ASGNetworkIn",
        .asg_network_out = "ASGNetworkOut",
        .alb_request_count = "ALBRequestCount",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .asgcpu_utilization => "ASGCPUUtilization",
            .asg_network_in => "ASGNetworkIn",
            .asg_network_out => "ASGNetworkOut",
            .alb_request_count => "ALBRequestCount",
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
