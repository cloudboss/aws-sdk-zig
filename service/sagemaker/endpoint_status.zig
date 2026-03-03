const std = @import("std");

pub const EndpointStatus = enum {
    out_of_service,
    creating,
    updating,
    system_updating,
    rolling_back,
    in_service,
    deleting,
    failed,
    update_rollback_failed,

    pub const json_field_names = .{
        .out_of_service = "OutOfService",
        .creating = "Creating",
        .updating = "Updating",
        .system_updating = "SystemUpdating",
        .rolling_back = "RollingBack",
        .in_service = "InService",
        .deleting = "Deleting",
        .failed = "Failed",
        .update_rollback_failed = "UpdateRollbackFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .out_of_service => "OutOfService",
            .creating => "Creating",
            .updating => "Updating",
            .system_updating => "SystemUpdating",
            .rolling_back => "RollingBack",
            .in_service => "InService",
            .deleting => "Deleting",
            .failed => "Failed",
            .update_rollback_failed => "UpdateRollbackFailed",
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
