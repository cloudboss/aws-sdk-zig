const std = @import("std");

pub const AssetType = enum {
    agent,
    space,
    knowledge_base,

    pub const json_field_names = .{
        .agent = "AGENT",
        .space = "SPACE",
        .knowledge_base = "KNOWLEDGE_BASE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agent => "AGENT",
            .space => "SPACE",
            .knowledge_base => "KNOWLEDGE_BASE",
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
