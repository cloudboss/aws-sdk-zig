const std = @import("std");

pub const MetadataGenerationRunStatus = enum {
    submitted,
    in_progress,
    canceled,
    succeeded,
    failed,
    partially_succeeded,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .canceled = "CANCELED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .partially_succeeded = "PARTIALLY_SUCCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .in_progress => "IN_PROGRESS",
            .canceled => "CANCELED",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .partially_succeeded => "PARTIALLY_SUCCEEDED",
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
