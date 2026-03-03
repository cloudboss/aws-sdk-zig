const std = @import("std");

pub const FlowOperationStatus = enum {
    completed,
    in_progress,
    failed,
    completed_with_errors,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .completed_with_errors = "COMPLETED_WITH_ERRORS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .completed => "COMPLETED",
            .in_progress => "IN_PROGRESS",
            .failed => "FAILED",
            .completed_with_errors => "COMPLETED_WITH_ERRORS",
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
