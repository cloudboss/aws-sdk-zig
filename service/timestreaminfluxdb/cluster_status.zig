const std = @import("std");

pub const ClusterStatus = enum {
    creating,
    updating,
    deleting,
    available,
    failed,
    deleted,
    maintenance,
    updating_instance_type,
    rebooting,
    reboot_failed,
    partially_available,
    restoring,
    restore_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .available = "AVAILABLE",
        .failed = "FAILED",
        .deleted = "DELETED",
        .maintenance = "MAINTENANCE",
        .updating_instance_type = "UPDATING_INSTANCE_TYPE",
        .rebooting = "REBOOTING",
        .reboot_failed = "REBOOT_FAILED",
        .partially_available = "PARTIALLY_AVAILABLE",
        .restoring = "RESTORING",
        .restore_failed = "RESTORE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .updating => "UPDATING",
            .deleting => "DELETING",
            .available => "AVAILABLE",
            .failed => "FAILED",
            .deleted => "DELETED",
            .maintenance => "MAINTENANCE",
            .updating_instance_type => "UPDATING_INSTANCE_TYPE",
            .rebooting => "REBOOTING",
            .reboot_failed => "REBOOT_FAILED",
            .partially_available => "PARTIALLY_AVAILABLE",
            .restoring => "RESTORING",
            .restore_failed => "RESTORE_FAILED",
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
