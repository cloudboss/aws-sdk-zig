const std = @import("std");

pub const RecordStatus = enum {
    created,
    in_progress,
    in_progress_in_error,
    succeeded,
    failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .in_progress = "IN_PROGRESS",
        .in_progress_in_error = "IN_PROGRESS_IN_ERROR",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .in_progress => "IN_PROGRESS",
            .in_progress_in_error => "IN_PROGRESS_IN_ERROR",
            .succeeded => "SUCCEEDED",
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
