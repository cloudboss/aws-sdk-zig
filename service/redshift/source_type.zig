const std = @import("std");

pub const SourceType = enum {
    cluster,
    cluster_parameter_group,
    cluster_security_group,
    cluster_snapshot,
    scheduled_action,

    pub const json_field_names = .{
        .cluster = "cluster",
        .cluster_parameter_group = "cluster-parameter-group",
        .cluster_security_group = "cluster-security-group",
        .cluster_snapshot = "cluster-snapshot",
        .scheduled_action = "scheduled-action",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cluster => "cluster",
            .cluster_parameter_group => "cluster-parameter-group",
            .cluster_security_group => "cluster-security-group",
            .cluster_snapshot => "cluster-snapshot",
            .scheduled_action => "scheduled-action",
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
