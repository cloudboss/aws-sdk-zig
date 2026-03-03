const std = @import("std");

pub const DeleteAgentErrorCode = enum {
    not_found,
    internal_server_error,
    agent_in_use,

    pub const json_field_names = .{
        .not_found = "NOT_FOUND",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
        .agent_in_use = "AGENT_IN_USE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_found => "NOT_FOUND",
            .internal_server_error => "INTERNAL_SERVER_ERROR",
            .agent_in_use => "AGENT_IN_USE",
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
