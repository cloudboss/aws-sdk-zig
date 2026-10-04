const std = @import("std");

pub const NetworkConnectorState = enum {
    /// Being created, resources provisioning
    pending,
    /// Active and ready for use
    active,
    /// Temporarily inactive
    inactive,
    /// Creation or update failed
    failed,
    /// Being deleted, cleaning up resources
    deleting,
    /// Deletion failed
    delete_failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .failed = "FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .active => "ACTIVE",
            .inactive => "INACTIVE",
            .failed => "FAILED",
            .deleting => "DELETING",
            .delete_failed => "DELETE_FAILED",
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
