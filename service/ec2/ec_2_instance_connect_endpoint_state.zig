const std = @import("std");

pub const Ec2InstanceConnectEndpointState = enum {
    create_in_progress,
    create_complete,
    create_failed,
    delete_in_progress,
    delete_complete,
    delete_failed,
    update_in_progress,
    update_complete,
    update_failed,

    pub const json_field_names = .{
        .create_in_progress = "create-in-progress",
        .create_complete = "create-complete",
        .create_failed = "create-failed",
        .delete_in_progress = "delete-in-progress",
        .delete_complete = "delete-complete",
        .delete_failed = "delete-failed",
        .update_in_progress = "update-in-progress",
        .update_complete = "update-complete",
        .update_failed = "update-failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "create-in-progress",
            .create_complete => "create-complete",
            .create_failed => "create-failed",
            .delete_in_progress => "delete-in-progress",
            .delete_complete => "delete-complete",
            .delete_failed => "delete-failed",
            .update_in_progress => "update-in-progress",
            .update_complete => "update-complete",
            .update_failed => "update-failed",
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
