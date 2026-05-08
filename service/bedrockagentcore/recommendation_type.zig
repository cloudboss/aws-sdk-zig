const std = @import("std");

pub const RecommendationType = enum {
    system_prompt_recommendation,
    tool_description_recommendation,

    pub const json_field_names = .{
        .system_prompt_recommendation = "SYSTEM_PROMPT_RECOMMENDATION",
        .tool_description_recommendation = "TOOL_DESCRIPTION_RECOMMENDATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .system_prompt_recommendation => "SYSTEM_PROMPT_RECOMMENDATION",
            .tool_description_recommendation => "TOOL_DESCRIPTION_RECOMMENDATION",
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
