const std = @import("std");

/// A signal map's monitor deployment status.
pub const SignalMapMonitorDeploymentStatus = enum {
    not_deployed,
    dry_run_deployment_complete,
    dry_run_deployment_failed,
    dry_run_deployment_in_progress,
    deployment_complete,
    deployment_failed,
    deployment_in_progress,
    delete_complete,
    delete_failed,
    delete_in_progress,

    pub const json_field_names = .{
        .not_deployed = "NOT_DEPLOYED",
        .dry_run_deployment_complete = "DRY_RUN_DEPLOYMENT_COMPLETE",
        .dry_run_deployment_failed = "DRY_RUN_DEPLOYMENT_FAILED",
        .dry_run_deployment_in_progress = "DRY_RUN_DEPLOYMENT_IN_PROGRESS",
        .deployment_complete = "DEPLOYMENT_COMPLETE",
        .deployment_failed = "DEPLOYMENT_FAILED",
        .deployment_in_progress = "DEPLOYMENT_IN_PROGRESS",
        .delete_complete = "DELETE_COMPLETE",
        .delete_failed = "DELETE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_deployed => "NOT_DEPLOYED",
            .dry_run_deployment_complete => "DRY_RUN_DEPLOYMENT_COMPLETE",
            .dry_run_deployment_failed => "DRY_RUN_DEPLOYMENT_FAILED",
            .dry_run_deployment_in_progress => "DRY_RUN_DEPLOYMENT_IN_PROGRESS",
            .deployment_complete => "DEPLOYMENT_COMPLETE",
            .deployment_failed => "DEPLOYMENT_FAILED",
            .deployment_in_progress => "DEPLOYMENT_IN_PROGRESS",
            .delete_complete => "DELETE_COMPLETE",
            .delete_failed => "DELETE_FAILED",
            .delete_in_progress => "DELETE_IN_PROGRESS",
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
