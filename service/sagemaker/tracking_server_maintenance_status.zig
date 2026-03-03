const std = @import("std");

pub const TrackingServerMaintenanceStatus = enum {
    maintenance_in_progress,
    maintenance_complete,
    maintenance_failed,

    pub const json_field_names = .{
        .maintenance_in_progress = "MaintenanceInProgress",
        .maintenance_complete = "MaintenanceComplete",
        .maintenance_failed = "MaintenanceFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .maintenance_in_progress => "MaintenanceInProgress",
            .maintenance_complete => "MaintenanceComplete",
            .maintenance_failed => "MaintenanceFailed",
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
