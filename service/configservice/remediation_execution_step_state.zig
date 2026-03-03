const std = @import("std");

pub const RemediationExecutionStepState = enum {
    succeeded,
    pending,
    failed,
    in_progress,
    exited,
    unknown,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .pending = "PENDING",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .exited = "EXITED",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .succeeded => "SUCCEEDED",
            .pending => "PENDING",
            .failed => "FAILED",
            .in_progress => "IN_PROGRESS",
            .exited => "EXITED",
            .unknown => "UNKNOWN",
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
