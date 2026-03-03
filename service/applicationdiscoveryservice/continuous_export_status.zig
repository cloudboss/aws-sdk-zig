const std = @import("std");

pub const ContinuousExportStatus = enum {
    start_in_progress,
    start_failed,
    active,
    @"error",
    stop_in_progress,
    stop_failed,
    inactive,

    pub const json_field_names = .{
        .start_in_progress = "START_IN_PROGRESS",
        .start_failed = "START_FAILED",
        .active = "ACTIVE",
        .@"error" = "ERROR",
        .stop_in_progress = "STOP_IN_PROGRESS",
        .stop_failed = "STOP_FAILED",
        .inactive = "INACTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_in_progress => "START_IN_PROGRESS",
            .start_failed => "START_FAILED",
            .active => "ACTIVE",
            .@"error" => "ERROR",
            .stop_in_progress => "STOP_IN_PROGRESS",
            .stop_failed => "STOP_FAILED",
            .inactive => "INACTIVE",
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
