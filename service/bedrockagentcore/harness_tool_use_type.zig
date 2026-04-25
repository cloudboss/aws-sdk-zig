const std = @import("std");

pub const HarnessToolUseType = enum {
    tool_use,
    server_tool_use,
    mcp_tool_use,

    pub const json_field_names = .{
        .tool_use = "tool_use",
        .server_tool_use = "server_tool_use",
        .mcp_tool_use = "mcp_tool_use",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tool_use => "tool_use",
            .server_tool_use => "server_tool_use",
            .mcp_tool_use => "mcp_tool_use",
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
