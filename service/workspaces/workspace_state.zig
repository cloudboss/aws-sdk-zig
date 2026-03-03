const std = @import("std");

pub const WorkspaceState = enum {
    pending,
    available,
    impaired,
    unhealthy,
    rebooting,
    starting,
    rebuilding,
    restoring,
    maintenance,
    admin_maintenance,
    terminating,
    terminated,
    suspended,
    updating,
    stopping,
    stopped,
    @"error",

    pub const json_field_names = .{
        .pending = "PENDING",
        .available = "AVAILABLE",
        .impaired = "IMPAIRED",
        .unhealthy = "UNHEALTHY",
        .rebooting = "REBOOTING",
        .starting = "STARTING",
        .rebuilding = "REBUILDING",
        .restoring = "RESTORING",
        .maintenance = "MAINTENANCE",
        .admin_maintenance = "ADMIN_MAINTENANCE",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .suspended = "SUSPENDED",
        .updating = "UPDATING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .available => "AVAILABLE",
            .impaired => "IMPAIRED",
            .unhealthy => "UNHEALTHY",
            .rebooting => "REBOOTING",
            .starting => "STARTING",
            .rebuilding => "REBUILDING",
            .restoring => "RESTORING",
            .maintenance => "MAINTENANCE",
            .admin_maintenance => "ADMIN_MAINTENANCE",
            .terminating => "TERMINATING",
            .terminated => "TERMINATED",
            .suspended => "SUSPENDED",
            .updating => "UPDATING",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .@"error" => "ERROR",
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
