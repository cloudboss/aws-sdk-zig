const std = @import("std");

pub const DescriptorType = enum {
    mcp,
    a2_a,
    custom,
    agent_skills,

    pub const json_field_names = .{
        .mcp = "MCP",
        .a2_a = "A2A",
        .custom = "CUSTOM",
        .agent_skills = "AGENT_SKILLS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mcp => "MCP",
            .a2_a => "A2A",
            .custom => "CUSTOM",
            .agent_skills => "AGENT_SKILLS",
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
