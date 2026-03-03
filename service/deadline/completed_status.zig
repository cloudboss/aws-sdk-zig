const std = @import("std");

pub const CompletedStatus = enum {
    succeeded,
    failed,
    interrupted,
    canceled,
    never_attempted,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
        .canceled = "CANCELED",
        .never_attempted = "NEVER_ATTEMPTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .interrupted => "INTERRUPTED",
            .canceled => "CANCELED",
            .never_attempted => "NEVER_ATTEMPTED",
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
