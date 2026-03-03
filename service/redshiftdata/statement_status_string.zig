const std = @import("std");

pub const StatementStatusString = enum {
    submitted,
    picked,
    started,
    finished,
    aborted,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .picked = "PICKED",
        .started = "STARTED",
        .finished = "FINISHED",
        .aborted = "ABORTED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .picked => "PICKED",
            .started => "STARTED",
            .finished => "FINISHED",
            .aborted => "ABORTED",
            .failed => "FAILED",
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
