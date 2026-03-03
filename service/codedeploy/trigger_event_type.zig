const std = @import("std");

pub const TriggerEventType = enum {
    deployment_start,
    deployment_success,
    deployment_failure,
    deployment_stop,
    deployment_rollback,
    deployment_ready,
    instance_start,
    instance_success,
    instance_failure,
    instance_ready,

    pub const json_field_names = .{
        .deployment_start = "DeploymentStart",
        .deployment_success = "DeploymentSuccess",
        .deployment_failure = "DeploymentFailure",
        .deployment_stop = "DeploymentStop",
        .deployment_rollback = "DeploymentRollback",
        .deployment_ready = "DeploymentReady",
        .instance_start = "InstanceStart",
        .instance_success = "InstanceSuccess",
        .instance_failure = "InstanceFailure",
        .instance_ready = "InstanceReady",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deployment_start => "DeploymentStart",
            .deployment_success => "DeploymentSuccess",
            .deployment_failure => "DeploymentFailure",
            .deployment_stop => "DeploymentStop",
            .deployment_rollback => "DeploymentRollback",
            .deployment_ready => "DeploymentReady",
            .instance_start => "InstanceStart",
            .instance_success => "InstanceSuccess",
            .instance_failure => "InstanceFailure",
            .instance_ready => "InstanceReady",
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
