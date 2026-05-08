const std = @import("std");

pub const BatchEvaluationStatus = enum {
    pending,
    in_progress,
    completed,
    completed_with_errors,
    failed,
    stopping,
    stopped,
    deleting,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .completed_with_errors = "COMPLETED_WITH_ERRORS",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .completed => "COMPLETED",
            .completed_with_errors => "COMPLETED_WITH_ERRORS",
            .failed => "FAILED",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .deleting => "DELETING",
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
