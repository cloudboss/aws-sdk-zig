const std = @import("std");

/// The type of deployment. When used for ''CreateDeployment'', only
/// ''NewDeployment'' and ''Redeployment'' are valid.
pub const DeploymentType = enum {
    new_deployment,
    redeployment,
    reset_deployment,
    force_reset_deployment,

    pub const json_field_names = .{
        .new_deployment = "NewDeployment",
        .redeployment = "Redeployment",
        .reset_deployment = "ResetDeployment",
        .force_reset_deployment = "ForceResetDeployment",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new_deployment => "NewDeployment",
            .redeployment => "Redeployment",
            .reset_deployment => "ResetDeployment",
            .force_reset_deployment => "ForceResetDeployment",
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
