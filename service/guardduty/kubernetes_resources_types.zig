const std = @import("std");

pub const KubernetesResourcesTypes = enum {
    pods,
    jobs,
    cronjobs,
    deployments,
    daemonsets,
    statefulsets,
    replicasets,
    replicationcontrollers,

    pub const json_field_names = .{
        .pods = "PODS",
        .jobs = "JOBS",
        .cronjobs = "CRONJOBS",
        .deployments = "DEPLOYMENTS",
        .daemonsets = "DAEMONSETS",
        .statefulsets = "STATEFULSETS",
        .replicasets = "REPLICASETS",
        .replicationcontrollers = "REPLICATIONCONTROLLERS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pods => "PODS",
            .jobs => "JOBS",
            .cronjobs => "CRONJOBS",
            .deployments => "DEPLOYMENTS",
            .daemonsets => "DAEMONSETS",
            .statefulsets => "STATEFULSETS",
            .replicasets => "REPLICASETS",
            .replicationcontrollers => "REPLICATIONCONTROLLERS",
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
