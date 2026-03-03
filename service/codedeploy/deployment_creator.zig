const std = @import("std");

pub const DeploymentCreator = enum {
    user,
    autoscaling,
    code_deploy_rollback,
    code_deploy,
    code_deploy_auto_update,
    cloud_formation,
    cloud_formation_rollback,
    autoscaling_termination,

    pub const json_field_names = .{
        .user = "user",
        .autoscaling = "autoscaling",
        .code_deploy_rollback = "codeDeployRollback",
        .code_deploy = "CodeDeploy",
        .code_deploy_auto_update = "CodeDeployAutoUpdate",
        .cloud_formation = "CloudFormation",
        .cloud_formation_rollback = "CloudFormationRollback",
        .autoscaling_termination = "autoscalingTermination",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user => "user",
            .autoscaling => "autoscaling",
            .code_deploy_rollback => "codeDeployRollback",
            .code_deploy => "CodeDeploy",
            .code_deploy_auto_update => "CodeDeployAutoUpdate",
            .cloud_formation => "CloudFormation",
            .cloud_formation_rollback => "CloudFormationRollback",
            .autoscaling_termination => "autoscalingTermination",
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
