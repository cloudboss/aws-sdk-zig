const std = @import("std");

/// The type of the AI agent.
pub const AIAgentType = enum {
    third_party,

    pub const json_field_names = .{
        .third_party = "THIRD_PARTY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .third_party => "THIRD_PARTY",
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
