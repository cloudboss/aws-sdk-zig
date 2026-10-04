const std = @import("std");

pub const IpamPoolState = enum {
    create_in_progress,
    create_complete,
    create_failed,
    modify_in_progress,
    modify_complete,
    modify_failed,
    delete_in_progress,
    delete_complete,
    delete_failed,
    isolate_in_progress,
    isolate_complete,
    restore_in_progress,

    pub const json_field_names = .{
        .create_in_progress = "create-in-progress",
        .create_complete = "create-complete",
        .create_failed = "create-failed",
        .modify_in_progress = "modify-in-progress",
        .modify_complete = "modify-complete",
        .modify_failed = "modify-failed",
        .delete_in_progress = "delete-in-progress",
        .delete_complete = "delete-complete",
        .delete_failed = "delete-failed",
        .isolate_in_progress = "isolate-in-progress",
        .isolate_complete = "isolate-complete",
        .restore_in_progress = "restore-in-progress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "create-in-progress",
            .create_complete => "create-complete",
            .create_failed => "create-failed",
            .modify_in_progress => "modify-in-progress",
            .modify_complete => "modify-complete",
            .modify_failed => "modify-failed",
            .delete_in_progress => "delete-in-progress",
            .delete_complete => "delete-complete",
            .delete_failed => "delete-failed",
            .isolate_in_progress => "isolate-in-progress",
            .isolate_complete => "isolate-complete",
            .restore_in_progress => "restore-in-progress",
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
