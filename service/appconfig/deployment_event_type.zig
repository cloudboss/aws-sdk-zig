const std = @import("std");

pub const DeploymentEventType = enum {
    percentage_updated,
    rollback_started,
    rollback_completed,
    bake_time_started,
    deployment_started,
    deployment_completed,
    revert_completed,

    pub const json_field_names = .{
        .percentage_updated = "PERCENTAGE_UPDATED",
        .rollback_started = "ROLLBACK_STARTED",
        .rollback_completed = "ROLLBACK_COMPLETED",
        .bake_time_started = "BAKE_TIME_STARTED",
        .deployment_started = "DEPLOYMENT_STARTED",
        .deployment_completed = "DEPLOYMENT_COMPLETED",
        .revert_completed = "REVERT_COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .percentage_updated => "PERCENTAGE_UPDATED",
            .rollback_started => "ROLLBACK_STARTED",
            .rollback_completed => "ROLLBACK_COMPLETED",
            .bake_time_started => "BAKE_TIME_STARTED",
            .deployment_started => "DEPLOYMENT_STARTED",
            .deployment_completed => "DEPLOYMENT_COMPLETED",
            .revert_completed => "REVERT_COMPLETED",
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
