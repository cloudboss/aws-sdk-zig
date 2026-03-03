const std = @import("std");

pub const DetailedModelPackageStatus = enum {
    not_started,
    in_progress,
    completed,
    failed,

    pub const json_field_names = .{
        .not_started = "NotStarted",
        .in_progress = "InProgress",
        .completed = "Completed",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NotStarted",
            .in_progress => "InProgress",
            .completed => "Completed",
            .failed => "Failed",
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
