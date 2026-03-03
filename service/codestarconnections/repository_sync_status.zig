const std = @import("std");

pub const RepositorySyncStatus = enum {
    failed,
    initiated,
    in_progress,
    succeeded,
    queued,

    pub const json_field_names = .{
        .failed = "FAILED",
        .initiated = "INITIATED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .queued = "QUEUED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed => "FAILED",
            .initiated => "INITIATED",
            .in_progress => "IN_PROGRESS",
            .succeeded => "SUCCEEDED",
            .queued => "QUEUED",
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
