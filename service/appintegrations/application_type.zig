const std = @import("std");

/// The type of application
pub const ApplicationType = enum {
    standard,
    service,
    mcp_server,
    a2_a_server,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .service = "SERVICE",
        .mcp_server = "MCP_SERVER",
        .a2_a_server = "A2A_SERVER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .service => "SERVICE",
            .mcp_server => "MCP_SERVER",
            .a2_a_server => "A2A_SERVER",
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
