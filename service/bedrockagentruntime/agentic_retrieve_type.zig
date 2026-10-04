const std = @import("std");

/// The type of retrieval source.
pub const AgenticRetrieveType = enum {
    /// A Bedrock knowledge base retrieval source.
    bedrock_knowledge_base,
    /// An AgentCore Memory resource. Long-term memory retrievals report under the
    /// Retrieval step with this source type.
    bedrock_agent_core_memory,

    pub const json_field_names = .{
        .bedrock_knowledge_base = "BedrockKnowledgeBase",
        .bedrock_agent_core_memory = "BedrockAgentCoreMemory",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bedrock_knowledge_base => "BedrockKnowledgeBase",
            .bedrock_agent_core_memory => "BedrockAgentCoreMemory",
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
