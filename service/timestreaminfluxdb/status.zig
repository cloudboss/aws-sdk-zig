const std = @import("std");

pub const Status = enum {
    creating,
    available,
    deleting,
    modifying,
    updating,
    deleted,
    failed,
    updating_deployment_type,
    updating_instance_type,
    maintenance,
    rebooting,
    reboot_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .deleting = "DELETING",
        .modifying = "MODIFYING",
        .updating = "UPDATING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .updating_deployment_type = "UPDATING_DEPLOYMENT_TYPE",
        .updating_instance_type = "UPDATING_INSTANCE_TYPE",
        .maintenance = "MAINTENANCE",
        .rebooting = "REBOOTING",
        .reboot_failed = "REBOOT_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .available => "AVAILABLE",
            .deleting => "DELETING",
            .modifying => "MODIFYING",
            .updating => "UPDATING",
            .deleted => "DELETED",
            .failed => "FAILED",
            .updating_deployment_type => "UPDATING_DEPLOYMENT_TYPE",
            .updating_instance_type => "UPDATING_INSTANCE_TYPE",
            .maintenance => "MAINTENANCE",
            .rebooting => "REBOOTING",
            .reboot_failed => "REBOOT_FAILED",
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
