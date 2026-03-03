const std = @import("std");

pub const ReplaceRootVolumeTaskState = enum {
    pending,
    in_progress,
    failing,
    succeeded,
    failed,
    failed_detached,

    pub const json_field_names = .{
        .pending = "pending",
        .in_progress = "in-progress",
        .failing = "failing",
        .succeeded = "succeeded",
        .failed = "failed",
        .failed_detached = "failed-detached",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .in_progress => "in-progress",
            .failing => "failing",
            .succeeded => "succeeded",
            .failed => "failed",
            .failed_detached => "failed-detached",
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
