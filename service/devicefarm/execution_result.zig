const std = @import("std");

pub const ExecutionResult = enum {
    pending,
    passed,
    warned,
    failed,
    skipped,
    errored,
    stopped,

    pub const json_field_names = .{
        .pending = "PENDING",
        .passed = "PASSED",
        .warned = "WARNED",
        .failed = "FAILED",
        .skipped = "SKIPPED",
        .errored = "ERRORED",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .passed => "PASSED",
            .warned => "WARNED",
            .failed => "FAILED",
            .skipped => "SKIPPED",
            .errored => "ERRORED",
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
