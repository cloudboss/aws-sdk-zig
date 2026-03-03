const std = @import("std");

pub const DeploymentLifecycle = enum {
    deploying,
    succeeded,
    failed,
    deploy_update,

    pub const json_field_names = .{
        .deploying = "Deploying",
        .succeeded = "Succeeded",
        .failed = "Failed",
        .deploy_update = "Updating Deployment",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deploying => "Deploying",
            .succeeded => "Succeeded",
            .failed => "Failed",
            .deploy_update => "Updating Deployment",
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
