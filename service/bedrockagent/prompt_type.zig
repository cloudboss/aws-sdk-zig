const std = @import("std");

pub const PromptType = enum {
    pre_processing,
    orchestration,
    post_processing,
    knowledge_base_response_generation,
    memory_summarization,

    pub const json_field_names = .{
        .pre_processing = "PRE_PROCESSING",
        .orchestration = "ORCHESTRATION",
        .post_processing = "POST_PROCESSING",
        .knowledge_base_response_generation = "KNOWLEDGE_BASE_RESPONSE_GENERATION",
        .memory_summarization = "MEMORY_SUMMARIZATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pre_processing => "PRE_PROCESSING",
            .orchestration => "ORCHESTRATION",
            .post_processing => "POST_PROCESSING",
            .knowledge_base_response_generation => "KNOWLEDGE_BASE_RESPONSE_GENERATION",
            .memory_summarization => "MEMORY_SUMMARIZATION",
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
