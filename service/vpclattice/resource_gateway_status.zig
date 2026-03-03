const std = @import("std");

pub const ResourceGatewayStatus = enum {
    /// Resource Gateway is active.
    active,
    /// Resource Gateway creation in progress.
    create_in_progress,
    /// Resource Gateway update in progress.
    update_in_progress,
    /// Resource Gateway deletion in progress
    delete_in_progress,
    /// Resource Gateway creation failed
    create_failed,
    /// Reosurce Gateway update failed
    update_failed,
    /// Resource Gateway deletion failed.
    delete_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .create_in_progress => "CREATE_IN_PROGRESS",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .create_failed => "CREATE_FAILED",
            .update_failed => "UPDATE_FAILED",
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
