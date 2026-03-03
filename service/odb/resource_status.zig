const std = @import("std");

pub const ResourceStatus = enum {
    available,
    failed,
    provisioning,
    terminated,
    terminating,
    updating,
    maintenance_in_progress,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .failed = "FAILED",
        .provisioning = "PROVISIONING",
        .terminated = "TERMINATED",
        .terminating = "TERMINATING",
        .updating = "UPDATING",
        .maintenance_in_progress = "MAINTENANCE_IN_PROGRESS",
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
