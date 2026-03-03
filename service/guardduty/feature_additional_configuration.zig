const std = @import("std");

pub const FeatureAdditionalConfiguration = enum {
    eks_addon_management,
    ecs_fargate_agent_management,
    ec2_agent_management,

    pub const json_field_names = .{
        .eks_addon_management = "EKS_ADDON_MANAGEMENT",
        .ecs_fargate_agent_management = "ECS_FARGATE_AGENT_MANAGEMENT",
        .ec2_agent_management = "EC2_AGENT_MANAGEMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eks_addon_management => "EKS_ADDON_MANAGEMENT",
            .ecs_fargate_agent_management => "ECS_FARGATE_AGENT_MANAGEMENT",
            .ec2_agent_management => "EC2_AGENT_MANAGEMENT",
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
