const std = @import("std");

/// The status of the job.
pub const ConfigurationJobStatus = enum {
    new,
    failed,
    in_progress,
    queued,
    success,

    pub const json_field_names = .{
        .new = "NEW",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .queued = "QUEUED",
        .success = "SUCCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .new => "NEW",
            .failed => "FAILED",
            .in_progress => "IN_PROGRESS",
            .queued => "QUEUED",
            .success => "SUCCESS",
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
