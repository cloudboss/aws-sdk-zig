const std = @import("std");

/// The broker's status.
pub const BrokerState = enum {
    creation_in_progress,
    creation_failed,
    deletion_in_progress,
    running,
    reboot_in_progress,
    critical_action_required,
    replica,

    pub const json_field_names = .{
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .creation_failed = "CREATION_FAILED",
        .deletion_in_progress = "DELETION_IN_PROGRESS",
        .running = "RUNNING",
        .reboot_in_progress = "REBOOT_IN_PROGRESS",
        .critical_action_required = "CRITICAL_ACTION_REQUIRED",
        .replica = "REPLICA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creation_in_progress => "CREATION_IN_PROGRESS",
            .creation_failed => "CREATION_FAILED",
            .deletion_in_progress => "DELETION_IN_PROGRESS",
            .running => "RUNNING",
            .reboot_in_progress => "REBOOT_IN_PROGRESS",
            .critical_action_required => "CRITICAL_ACTION_REQUIRED",
            .replica => "REPLICA",
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
