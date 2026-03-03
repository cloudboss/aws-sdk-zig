const std = @import("std");

/// A job query's status can be SUBMITTED, PROGRESSING, COMPLETE, or ERROR.
pub const JobsQueryStatus = enum {
    submitted,
    progressing,
    complete,
    @"error",

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .progressing = "PROGRESSING",
        .complete = "COMPLETE",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .progressing => "PROGRESSING",
            .complete => "COMPLETE",
            .@"error" => "ERROR",
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
