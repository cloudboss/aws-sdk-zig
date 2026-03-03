const std = @import("std");

pub const DeploymentWaitType = enum {
    ready_wait,
    termination_wait,

    pub const json_field_names = .{
        .ready_wait = "READY_WAIT",
        .termination_wait = "TERMINATION_WAIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready_wait => "READY_WAIT",
            .termination_wait => "TERMINATION_WAIT",
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
