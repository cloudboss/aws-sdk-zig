const std = @import("std");

pub const AssessmentStatus = enum {
    not_started,
    pending,
    in_progress,
    failed,
    success,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .success = "SUCCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NOT_STARTED",
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .failed => "FAILED",
            .success => "SUCCESS",
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
