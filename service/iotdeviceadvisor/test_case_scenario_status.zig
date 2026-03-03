const std = @import("std");

pub const TestCaseScenarioStatus = enum {
    pass,
    fail,
    canceled,
    pending,
    running,
    stopping,
    stopped,
    pass_with_warnings,
    @"error",

    pub const json_field_names = .{
        .pass = "PASS",
        .fail = "FAIL",
        .canceled = "CANCELED",
        .pending = "PENDING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .pass_with_warnings = "PASS_WITH_WARNINGS",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pass => "PASS",
            .fail => "FAIL",
            .canceled => "CANCELED",
            .pending => "PENDING",
            .running => "RUNNING",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .pass_with_warnings => "PASS_WITH_WARNINGS",
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
