const std = @import("std");

pub const NodeType = enum {
    flow_input_node,
    flow_output_node,
    lambda_function_node,
    knowledge_base_node,
    prompt_node,
    condition_node,
    lex_node,

    pub const json_field_names = .{
        .flow_input_node = "FlowInputNode",
        .flow_output_node = "FlowOutputNode",
        .lambda_function_node = "LambdaFunctionNode",
        .knowledge_base_node = "KnowledgeBaseNode",
        .prompt_node = "PromptNode",
        .condition_node = "ConditionNode",
        .lex_node = "LexNode",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .flow_input_node => "FlowInputNode",
            .flow_output_node => "FlowOutputNode",
            .lambda_function_node => "LambdaFunctionNode",
            .knowledge_base_node => "KnowledgeBaseNode",
            .prompt_node => "PromptNode",
            .condition_node => "ConditionNode",
            .lex_node => "LexNode",
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
