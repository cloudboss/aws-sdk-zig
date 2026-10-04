const std = @import("std");

/// The state of an IPAM internet registry association.
pub const IpamInternetRegistryAssociationState = enum {
    pending_enable,
    create_in_progress,
    create_failed,
    enable_in_progress,
    enable_complete,
    enable_failed,
    disable_in_progress,
    disable_complete,
    disable_failed,
    delete_in_progress,
    delete_complete,
    delete_failed,

    pub const json_field_names = .{
        .pending_enable = "pending-enable",
        .create_in_progress = "create-in-progress",
        .create_failed = "create-failed",
        .enable_in_progress = "enable-in-progress",
        .enable_complete = "enable-complete",
        .enable_failed = "enable-failed",
        .disable_in_progress = "disable-in-progress",
        .disable_complete = "disable-complete",
        .disable_failed = "disable-failed",
        .delete_in_progress = "delete-in-progress",
        .delete_complete = "delete-complete",
        .delete_failed = "delete-failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_enable => "pending-enable",
            .create_in_progress => "create-in-progress",
            .create_failed => "create-failed",
            .enable_in_progress => "enable-in-progress",
            .enable_complete => "enable-complete",
            .enable_failed => "enable-failed",
            .disable_in_progress => "disable-in-progress",
            .disable_complete => "disable-complete",
            .disable_failed => "disable-failed",
            .delete_in_progress => "delete-in-progress",
            .delete_complete => "delete-complete",
            .delete_failed => "delete-failed",
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
