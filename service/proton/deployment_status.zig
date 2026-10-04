const std = @import("std");

pub const DeploymentStatus = enum {
    in_progress,
    failed,
    succeeded,
    delete_in_progress,
    delete_failed,
    delete_complete,
    cancelling,
    cancelled,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .delete_failed = "DELETE_FAILED",
        .delete_complete = "DELETE_COMPLETE",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .failed => "FAILED",
            .succeeded => "SUCCEEDED",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .delete_failed => "DELETE_FAILED",
            .delete_complete => "DELETE_COMPLETE",
            .cancelling => "CANCELLING",
            .cancelled => "CANCELLED",
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
