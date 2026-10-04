const std = @import("std");

pub const NotebookInstanceStatus = enum {
    pending,
    in_service,
    stopping,
    stopped,
    failed,
    deleting,
    updating,
    pending_maintenance,
    in_maintenance,

    pub const json_field_names = .{
        .pending = "Pending",
        .in_service = "InService",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .failed = "Failed",
        .deleting = "Deleting",
        .updating = "Updating",
        .pending_maintenance = "PendingMaintenance",
        .in_maintenance = "InMaintenance",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .in_service => "InService",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .failed => "Failed",
            .deleting => "Deleting",
            .updating => "Updating",
            .pending_maintenance => "PendingMaintenance",
            .in_maintenance => "InMaintenance",
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
