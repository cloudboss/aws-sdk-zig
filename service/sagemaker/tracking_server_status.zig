const std = @import("std");

pub const TrackingServerStatus = enum {
    creating,
    created,
    create_failed,
    updating,
    updated,
    update_failed,
    deleting,
    delete_failed,
    stopping,
    stopped,
    stop_failed,
    starting,
    started,
    start_failed,
    maintenance_in_progress,
    maintenance_complete,
    maintenance_failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .created = "Created",
        .create_failed = "CreateFailed",
        .updating = "Updating",
        .updated = "Updated",
        .update_failed = "UpdateFailed",
        .deleting = "Deleting",
        .delete_failed = "DeleteFailed",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .stop_failed = "StopFailed",
        .starting = "Starting",
        .started = "Started",
        .start_failed = "StartFailed",
        .maintenance_in_progress = "MaintenanceInProgress",
        .maintenance_complete = "MaintenanceComplete",
        .maintenance_failed = "MaintenanceFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "Creating",
            .created => "Created",
            .create_failed => "CreateFailed",
            .updating => "Updating",
            .updated => "Updated",
            .update_failed => "UpdateFailed",
            .deleting => "Deleting",
            .delete_failed => "DeleteFailed",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .stop_failed => "StopFailed",
            .starting => "Starting",
            .started => "Started",
            .start_failed => "StartFailed",
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
