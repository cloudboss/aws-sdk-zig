const std = @import("std");

pub const CRType = enum {
    ec2,
    spot,
    fargate,
    fargate_spot,
    ecs_managed_instances,

    pub const json_field_names = .{
        .ec2 = "EC2",
        .spot = "SPOT",
        .fargate = "FARGATE",
        .fargate_spot = "FARGATE_SPOT",
        .ecs_managed_instances = "ECS_MANAGED_INSTANCES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2 => "EC2",
            .spot => "SPOT",
            .fargate => "FARGATE",
            .fargate_spot => "FARGATE_SPOT",
            .ecs_managed_instances => "ECS_MANAGED_INSTANCES",
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
