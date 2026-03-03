const std = @import("std");

pub const UploadJobStatus = enum {
    created,
    in_progress,
    partially_succeeded,
    succeeded,
    failed,
    stopped,

    pub const json_field_names = .{
        .created = "CREATED",
        .in_progress = "IN_PROGRESS",
        .partially_succeeded = "PARTIALLY_SUCCEEDED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .in_progress => "IN_PROGRESS",
            .partially_succeeded => "PARTIALLY_SUCCEEDED",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .stopped => "STOPPED",
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
