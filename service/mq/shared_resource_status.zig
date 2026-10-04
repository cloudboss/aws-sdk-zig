const std = @import("std");

/// The status of the shared resource.
pub const SharedResourceStatus = enum {
    available,
    setup_in_progress,
    deletion_in_progress,
    pending_create,
    pending_delete,
    @"error",

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .setup_in_progress = "SETUP_IN_PROGRESS",
        .deletion_in_progress = "DELETION_IN_PROGRESS",
        .pending_create = "PENDING_CREATE",
        .pending_delete = "PENDING_DELETE",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .setup_in_progress => "SETUP_IN_PROGRESS",
            .deletion_in_progress => "DELETION_IN_PROGRESS",
            .pending_create => "PENDING_CREATE",
            .pending_delete => "PENDING_DELETE",
            .@"error" => "ERROR",
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
