const std = @import("std");

/// The state of a routing policy registration.
pub const IpamRoutingPolicyRegistrationState = enum {
    pending_activate,
    activate_failed,
    create_in_progress,
    create_complete,
    update_in_progress,
    update_complete,
    delete_in_progress,
    delete_complete,

    pub const json_field_names = .{
        .pending_activate = "pending-activate",
        .activate_failed = "activate-failed",
        .create_in_progress = "create-in-progress",
        .create_complete = "create-complete",
        .update_in_progress = "update-in-progress",
        .update_complete = "update-complete",
        .delete_in_progress = "delete-in-progress",
        .delete_complete = "delete-complete",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_activate => "pending-activate",
            .activate_failed => "activate-failed",
            .create_in_progress => "create-in-progress",
            .create_complete => "create-complete",
            .update_in_progress => "update-in-progress",
            .update_complete => "update-complete",
            .delete_in_progress => "delete-in-progress",
            .delete_complete => "delete-complete",
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
