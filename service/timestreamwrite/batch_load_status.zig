const std = @import("std");

pub const BatchLoadStatus = enum {
    created,
    in_progress,
    failed,
    succeeded,
    progress_stopped,
    pending_resume,

    pub const json_field_names = .{
        .created = "CREATED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .progress_stopped = "PROGRESS_STOPPED",
        .pending_resume = "PENDING_RESUME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .in_progress => "IN_PROGRESS",
            .failed => "FAILED",
            .succeeded => "SUCCEEDED",
            .progress_stopped => "PROGRESS_STOPPED",
            .pending_resume => "PENDING_RESUME",
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
