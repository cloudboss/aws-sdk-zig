const std = @import("std");

pub const AutonomousDatabaseResourceStatus = enum {
    available,
    failed,
    provisioning,
    terminated,
    terminating,
    updating,
    maintenance_in_progress,
    stopping,
    stopped,
    starting,
    unavailable,
    restore_in_progress,
    restore_failed,
    backup_in_progress,
    scale_in_progress,
    available_needs_attention,
    restarting,
    recreating,
    role_change_in_progress,
    upgrading,
    inaccessible,
    standby,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .failed = "FAILED",
        .provisioning = "PROVISIONING",
        .terminated = "TERMINATED",
        .terminating = "TERMINATING",
        .updating = "UPDATING",
        .maintenance_in_progress = "MAINTENANCE_IN_PROGRESS",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .starting = "STARTING",
        .unavailable = "UNAVAILABLE",
        .restore_in_progress = "RESTORE_IN_PROGRESS",
        .restore_failed = "RESTORE_FAILED",
        .backup_in_progress = "BACKUP_IN_PROGRESS",
        .scale_in_progress = "SCALE_IN_PROGRESS",
        .available_needs_attention = "AVAILABLE_NEEDS_ATTENTION",
        .restarting = "RESTARTING",
        .recreating = "RECREATING",
        .role_change_in_progress = "ROLE_CHANGE_IN_PROGRESS",
        .upgrading = "UPGRADING",
        .inaccessible = "INACCESSIBLE",
        .standby = "STANDBY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .failed => "FAILED",
            .provisioning => "PROVISIONING",
            .terminated => "TERMINATED",
            .terminating => "TERMINATING",
            .updating => "UPDATING",
            .maintenance_in_progress => "MAINTENANCE_IN_PROGRESS",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .starting => "STARTING",
            .unavailable => "UNAVAILABLE",
            .restore_in_progress => "RESTORE_IN_PROGRESS",
            .restore_failed => "RESTORE_FAILED",
            .backup_in_progress => "BACKUP_IN_PROGRESS",
            .scale_in_progress => "SCALE_IN_PROGRESS",
            .available_needs_attention => "AVAILABLE_NEEDS_ATTENTION",
            .restarting => "RESTARTING",
            .recreating => "RECREATING",
            .role_change_in_progress => "ROLE_CHANGE_IN_PROGRESS",
            .upgrading => "UPGRADING",
            .inaccessible => "INACCESSIBLE",
            .standby => "STANDBY",
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
