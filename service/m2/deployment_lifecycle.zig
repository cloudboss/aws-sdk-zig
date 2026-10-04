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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
