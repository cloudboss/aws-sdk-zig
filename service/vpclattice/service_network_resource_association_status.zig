const std = @import("std");

pub const ServiceNetworkResourceAssociationStatus = enum {
    /// ServiceNetwork and Service association creation in progress
    create_in_progress,
    /// ServiceNetwork and Service association is active
    active,
    /// ServiceNetwork and Service association is partial
    partial,
    /// ServiceNetwork and Service association deletion in progress
    delete_in_progress,
    /// ServiceNetwork and Service association creation failed.
    create_failed,
    /// ServiceNetwork and Service association deletion failed
    delete_failed,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .active = "ACTIVE",
        .partial = "PARTIAL",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .active => "ACTIVE",
            .partial => "PARTIAL",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .create_failed => "CREATE_FAILED",
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
