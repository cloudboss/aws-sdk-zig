const std = @import("std");

pub const UpdateProgress = enum {
    pending,
    in_progress,
    verifying,
    rebooting,
    downloading,
    completed,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .verifying = "VERIFYING",
        .rebooting = "REBOOTING",
        .downloading = "DOWNLOADING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .verifying => "VERIFYING",
            .rebooting => "REBOOTING",
            .downloading => "DOWNLOADING",
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
