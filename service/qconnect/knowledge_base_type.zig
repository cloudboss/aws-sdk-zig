const std = @import("std");

pub const KnowledgeBaseType = enum {
    external,
    custom,
    quick_responses,
    message_templates,
    managed,

    pub const json_field_names = .{
        .external = "EXTERNAL",
        .custom = "CUSTOM",
        .quick_responses = "QUICK_RESPONSES",
        .message_templates = "MESSAGE_TEMPLATES",
        .managed = "MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .external => "EXTERNAL",
            .custom => "CUSTOM",
            .quick_responses => "QUICK_RESPONSES",
            .message_templates => "MESSAGE_TEMPLATES",
            .managed => "MANAGED",
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
