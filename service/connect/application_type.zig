const std = @import("std");

pub const ApplicationType = enum {
    mcp,
    third_party_application,

    pub const json_field_names = .{
        .mcp = "MCP",
        .third_party_application = "THIRD_PARTY_APPLICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mcp => "MCP",
            .third_party_application => "THIRD_PARTY_APPLICATION",
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
