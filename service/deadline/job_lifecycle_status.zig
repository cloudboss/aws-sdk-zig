const std = @import("std");

pub const JobLifecycleStatus = enum {
    create_in_progress,
    create_failed,
    create_complete,
    upload_in_progress,
    upload_failed,
    update_in_progress,
    update_failed,
    update_succeeded,
    archived,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .create_complete = "CREATE_COMPLETE",
        .upload_in_progress = "UPLOAD_IN_PROGRESS",
        .upload_failed = "UPLOAD_FAILED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
        .update_succeeded = "UPDATE_SUCCEEDED",
        .archived = "ARCHIVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_failed => "CREATE_FAILED",
            .create_complete => "CREATE_COMPLETE",
            .upload_in_progress => "UPLOAD_IN_PROGRESS",
            .upload_failed => "UPLOAD_FAILED",
            .update_in_progress => "UPDATE_IN_PROGRESS",
            .update_failed => "UPDATE_FAILED",
            .update_succeeded => "UPDATE_SUCCEEDED",
            .archived => "ARCHIVED",
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
