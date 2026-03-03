const std = @import("std");

pub const StackInstanceDetailedStatus = enum {
    pending,
    running,
    succeeded,
    failed,
    cancelled,
    inoperable,
    skipped_suspended_account,
    failed_import,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .inoperable = "INOPERABLE",
        .skipped_suspended_account = "SKIPPED_SUSPENDED_ACCOUNT",
        .failed_import = "FAILED_IMPORT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .running => "RUNNING",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .cancelled => "CANCELLED",
            .inoperable => "INOPERABLE",
            .skipped_suspended_account => "SKIPPED_SUSPENDED_ACCOUNT",
            .failed_import => "FAILED_IMPORT",
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
