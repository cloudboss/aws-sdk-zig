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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
