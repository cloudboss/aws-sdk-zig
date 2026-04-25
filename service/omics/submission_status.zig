const std = @import("std");

pub const SubmissionStatus = enum {
    success,
    failed,
    cancel_success,
    cancel_failed,
    delete_success,
    delete_failed,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failed = "FAILED",
        .cancel_success = "CANCEL_SUCCESS",
        .cancel_failed = "CANCEL_FAILED",
        .delete_success = "DELETE_SUCCESS",
        .delete_failed = "DELETE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .failed => "FAILED",
            .cancel_success => "CANCEL_SUCCESS",
            .cancel_failed => "CANCEL_FAILED",
            .delete_success => "DELETE_SUCCESS",
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
