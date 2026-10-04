const std = @import("std");

/// The current execution state of a prospecting task. A task transitions from
/// `PENDING` to `IN_PROGRESS` when processing begins, and then to either
/// `COMPLETED` or `FAILED` when processing ends.
pub const ProspectingTaskStatus = enum {
    pending,
    in_progress,
    completed,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .completed => "COMPLETED",
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
