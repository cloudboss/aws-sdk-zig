const std = @import("std");

pub const ReportStatus = enum {
    work_in_progress,
    failed,
    completed,

    pub const json_field_names = .{
        .work_in_progress = "WORK_IN_PROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .work_in_progress => "WORK_IN_PROGRESS",
            .failed => "FAILED",
            .completed => "COMPLETED",
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
