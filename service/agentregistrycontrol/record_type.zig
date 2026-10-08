const std = @import("std");

/// Record type enum for registry record classification
pub const RecordType = enum {
    mcp,
    agent,
    custom,
    skill,
    gateway,

    pub const json_field_names = .{
        .mcp = "MCP",
        .agent = "AGENT",
        .custom = "CUSTOM",
        .skill = "SKILL",
        .gateway = "GATEWAY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mcp => "MCP",
            .agent => "AGENT",
            .custom => "CUSTOM",
            .skill => "SKILL",
            .gateway => "GATEWAY",
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
