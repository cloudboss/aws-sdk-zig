const std = @import("std");

pub const ResponseScope = enum {
    enterprise_content_only,
    extended_knowledge_enabled,

    pub const json_field_names = .{
        .enterprise_content_only = "ENTERPRISE_CONTENT_ONLY",
        .extended_knowledge_enabled = "EXTENDED_KNOWLEDGE_ENABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enterprise_content_only => "ENTERPRISE_CONTENT_ONLY",
            .extended_knowledge_enabled => "EXTENDED_KNOWLEDGE_ENABLED",
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
