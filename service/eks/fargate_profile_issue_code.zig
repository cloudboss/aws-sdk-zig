const std = @import("std");

pub const FargateProfileIssueCode = enum {
    pod_execution_role_already_in_use,
    access_denied,
    cluster_unreachable,
    internal_failure,

    pub const json_field_names = .{
        .pod_execution_role_already_in_use = "PodExecutionRoleAlreadyInUse",
        .access_denied = "AccessDenied",
        .cluster_unreachable = "ClusterUnreachable",
        .internal_failure = "InternalFailure",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pod_execution_role_already_in_use => "PodExecutionRoleAlreadyInUse",
            .access_denied => "AccessDenied",
            .cluster_unreachable => "ClusterUnreachable",
            .internal_failure => "InternalFailure",
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
