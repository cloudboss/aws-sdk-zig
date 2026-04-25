const std = @import("std");

pub const SessionState = enum {
    submitted,
    starting,
    started,
    idle,
    busy,
    failed,
    terminating,
    terminated,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .starting = "STARTING",
        .started = "STARTED",
        .idle = "IDLE",
        .busy = "BUSY",
        .failed = "FAILED",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .starting => "STARTING",
            .started => "STARTED",
            .idle => "IDLE",
            .busy => "BUSY",
            .failed => "FAILED",
            .terminating => "TERMINATING",
            .terminated => "TERMINATED",
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
