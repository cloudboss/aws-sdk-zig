const std = @import("std");

pub const JobStatus = enum {
    in_progress,
    canceled,
    completed,
    deletion_in_progress,
    scheduled,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .canceled = "CANCELED",
        .completed = "COMPLETED",
        .deletion_in_progress = "DELETION_IN_PROGRESS",
        .scheduled = "SCHEDULED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .canceled => "CANCELED",
            .completed => "COMPLETED",
            .deletion_in_progress => "DELETION_IN_PROGRESS",
            .scheduled => "SCHEDULED",
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
