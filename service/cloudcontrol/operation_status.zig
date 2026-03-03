const std = @import("std");

pub const OperationStatus = enum {
    pending,
    in_progress,
    success,
    failed,
    cancel_in_progress,
    cancel_complete,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failed = "FAILED",
        .cancel_in_progress = "CANCEL_IN_PROGRESS",
        .cancel_complete = "CANCEL_COMPLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .success => "SUCCESS",
            .failed => "FAILED",
            .cancel_in_progress => "CANCEL_IN_PROGRESS",
            .cancel_complete => "CANCEL_COMPLETE",
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
