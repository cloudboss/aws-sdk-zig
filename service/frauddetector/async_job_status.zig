const std = @import("std");

pub const AsyncJobStatus = enum {
    in_progress_initializing,
    in_progress,
    cancel_in_progress,
    canceled,
    complete,
    failed,

    pub const json_field_names = .{
        .in_progress_initializing = "IN_PROGRESS_INITIALIZING",
        .in_progress = "IN_PROGRESS",
        .cancel_in_progress = "CANCEL_IN_PROGRESS",
        .canceled = "CANCELED",
        .complete = "COMPLETE",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress_initializing => "IN_PROGRESS_INITIALIZING",
            .in_progress => "IN_PROGRESS",
            .cancel_in_progress => "CANCEL_IN_PROGRESS",
            .canceled => "CANCELED",
            .complete => "COMPLETE",
            .failed => "FAILED",
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
