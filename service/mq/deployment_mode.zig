const std = @import("std");

/// The broker's deployment mode.
pub const DeploymentMode = enum {
    single_instance,
    active_standby_multi_az,
    cluster_multi_az,

    pub const json_field_names = .{
        .single_instance = "SINGLE_INSTANCE",
        .active_standby_multi_az = "ACTIVE_STANDBY_MULTI_AZ",
        .cluster_multi_az = "CLUSTER_MULTI_AZ",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_instance => "SINGLE_INSTANCE",
            .active_standby_multi_az => "ACTIVE_STANDBY_MULTI_AZ",
            .cluster_multi_az => "CLUSTER_MULTI_AZ",
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
