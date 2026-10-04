const std = @import("std");

pub const Source = enum {
    action_group,
    knowledge_base,
    parser,

    pub const json_field_names = .{
        .action_group = "ACTION_GROUP",
        .knowledge_base = "KNOWLEDGE_BASE",
        .parser = "PARSER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .action_group => "ACTION_GROUP",
            .knowledge_base => "KNOWLEDGE_BASE",
            .parser => "PARSER",
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
