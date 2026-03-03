const std = @import("std");

pub const RunAs = enum {
    queue_configured_user,
    worker_agent_user,

    pub const json_field_names = .{
        .queue_configured_user = "QUEUE_CONFIGURED_USER",
        .worker_agent_user = "WORKER_AGENT_USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queue_configured_user => "QUEUE_CONFIGURED_USER",
            .worker_agent_user => "WORKER_AGENT_USER",
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
