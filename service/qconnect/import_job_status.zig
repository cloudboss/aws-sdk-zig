const std = @import("std");

pub const ImportJobStatus = enum {
    start_in_progress,
    failed,
    complete,
    delete_in_progress,
    delete_failed,
    deleted,

    pub const json_field_names = .{
        .start_in_progress = "START_IN_PROGRESS",
        .failed = "FAILED",
        .complete = "COMPLETE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_in_progress => "START_IN_PROGRESS",
            .failed => "FAILED",
            .complete => "COMPLETE",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .delete_failed => "DELETE_FAILED",
            .deleted => "DELETED",
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
