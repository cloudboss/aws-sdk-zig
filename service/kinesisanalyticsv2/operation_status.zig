const std = @import("std");

/// The status of the operation.
pub const OperationStatus = enum {
    in_progress,
    cancelled,
    successful,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .cancelled = "CANCELLED",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .cancelled => "CANCELLED",
            .successful => "SUCCESSFUL",
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
