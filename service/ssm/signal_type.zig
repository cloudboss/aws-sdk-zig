const std = @import("std");

pub const SignalType = enum {
    approve,
    reject,
    start_step,
    stop_step,
    @"resume",
    revoke,

    pub const json_field_names = .{
        .approve = "Approve",
        .reject = "Reject",
        .start_step = "StartStep",
        .stop_step = "StopStep",
        .@"resume" = "Resume",
        .revoke = "Revoke",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .approve => "Approve",
            .reject => "Reject",
            .start_step => "StartStep",
            .stop_step => "StopStep",
            .@"resume" => "Resume",
            .revoke => "Revoke",
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
