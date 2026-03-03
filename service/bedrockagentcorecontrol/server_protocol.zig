const std = @import("std");

pub const ServerProtocol = enum {
    mcp,
    http,
    a2_a,

    pub const json_field_names = .{
        .mcp = "MCP",
        .http = "HTTP",
        .a2_a = "A2A",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mcp => "MCP",
            .http => "HTTP",
            .a2_a => "A2A",
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
