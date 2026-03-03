const std = @import("std");

pub const OpenLineageRunState = enum {
    start,
    running,
    complete,
    abort,
    fail,
    other,

    pub const json_field_names = .{
        .start = "START",
        .running = "RUNNING",
        .complete = "COMPLETE",
        .abort = "ABORT",
        .fail = "FAIL",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start => "START",
            .running => "RUNNING",
            .complete => "COMPLETE",
            .abort => "ABORT",
            .fail => "FAIL",
            .other => "OTHER",
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
