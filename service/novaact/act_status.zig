const std = @import("std");

pub const ActStatus = enum {
    running,
    pending_client_action,
    pending_human_action,
    succeeded,
    failed,
    timed_out,

    pub const json_field_names = .{
        .running = "RUNNING",
        .pending_client_action = "PENDING_CLIENT_ACTION",
        .pending_human_action = "PENDING_HUMAN_ACTION",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "RUNNING",
            .pending_client_action => "PENDING_CLIENT_ACTION",
            .pending_human_action => "PENDING_HUMAN_ACTION",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .timed_out => "TIMED_OUT",
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
