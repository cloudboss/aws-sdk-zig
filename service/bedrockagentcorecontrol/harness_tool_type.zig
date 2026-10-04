const std = @import("std");

pub const HarnessToolType = enum {
    remote_mcp,
    agentcore_browser,
    agentcore_gateway,
    inline_function,
    agentcore_code_interpreter,

    pub const json_field_names = .{
        .remote_mcp = "remote_mcp",
        .agentcore_browser = "agentcore_browser",
        .agentcore_gateway = "agentcore_gateway",
        .inline_function = "inline_function",
        .agentcore_code_interpreter = "agentcore_code_interpreter",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .remote_mcp => "remote_mcp",
            .agentcore_browser => "agentcore_browser",
            .agentcore_gateway => "agentcore_gateway",
            .inline_function => "inline_function",
            .agentcore_code_interpreter => "agentcore_code_interpreter",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
