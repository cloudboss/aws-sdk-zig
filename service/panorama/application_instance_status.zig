const std = @import("std");

pub const ApplicationInstanceStatus = enum {
    deployment_pending,
    deployment_requested,
    deployment_in_progress,
    deployment_error,
    deployment_succeeded,
    removal_pending,
    removal_requested,
    removal_in_progress,
    removal_failed,
    removal_succeeded,
    deployment_failed,

    pub const json_field_names = .{
        .deployment_pending = "DEPLOYMENT_PENDING",
        .deployment_requested = "DEPLOYMENT_REQUESTED",
        .deployment_in_progress = "DEPLOYMENT_IN_PROGRESS",
        .deployment_error = "DEPLOYMENT_ERROR",
        .deployment_succeeded = "DEPLOYMENT_SUCCEEDED",
        .removal_pending = "REMOVAL_PENDING",
        .removal_requested = "REMOVAL_REQUESTED",
        .removal_in_progress = "REMOVAL_IN_PROGRESS",
        .removal_failed = "REMOVAL_FAILED",
        .removal_succeeded = "REMOVAL_SUCCEEDED",
        .deployment_failed = "DEPLOYMENT_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deployment_pending => "DEPLOYMENT_PENDING",
            .deployment_requested => "DEPLOYMENT_REQUESTED",
            .deployment_in_progress => "DEPLOYMENT_IN_PROGRESS",
            .deployment_error => "DEPLOYMENT_ERROR",
            .deployment_succeeded => "DEPLOYMENT_SUCCEEDED",
            .removal_pending => "REMOVAL_PENDING",
            .removal_requested => "REMOVAL_REQUESTED",
            .removal_in_progress => "REMOVAL_IN_PROGRESS",
            .removal_failed => "REMOVAL_FAILED",
            .removal_succeeded => "REMOVAL_SUCCEEDED",
            .deployment_failed => "DEPLOYMENT_FAILED",
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
