const std = @import("std");

pub const CapacityProviderType = enum {
    ec2_autoscaling,
    managed_instances,
    fargate,
    fargate_spot,

    pub const json_field_names = .{
        .ec2_autoscaling = "EC2_AUTOSCALING",
        .managed_instances = "MANAGED_INSTANCES",
        .fargate = "FARGATE",
        .fargate_spot = "FARGATE_SPOT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_autoscaling => "EC2_AUTOSCALING",
            .managed_instances => "MANAGED_INSTANCES",
            .fargate => "FARGATE",
            .fargate_spot => "FARGATE_SPOT",
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
