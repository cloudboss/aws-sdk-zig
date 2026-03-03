const std = @import("std");

pub const DeploymentTargetType = enum {
    instance_target,
    lambda_target,
    ecs_target,
    cloudformation_target,

    pub const json_field_names = .{
        .instance_target = "InstanceTarget",
        .lambda_target = "LambdaTarget",
        .ecs_target = "ECSTarget",
        .cloudformation_target = "CloudFormationTarget",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_target => "InstanceTarget",
            .lambda_target => "LambdaTarget",
            .ecs_target => "ECSTarget",
            .cloudformation_target => "CloudFormationTarget",
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
