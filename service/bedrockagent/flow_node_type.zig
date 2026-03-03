const std = @import("std");

pub const FlowNodeType = enum {
    input,
    output,
    knowledge_base,
    condition,
    lex,
    prompt,
    lambda_function,
    storage,
    agent,
    retrieval,
    iterator,
    collector,
    inline_code,
    loop,
    loop_input,
    loop_controller,

    pub const json_field_names = .{
        .input = "Input",
        .output = "Output",
        .knowledge_base = "KnowledgeBase",
        .condition = "Condition",
        .lex = "Lex",
        .prompt = "Prompt",
        .lambda_function = "LambdaFunction",
        .storage = "Storage",
        .agent = "Agent",
        .retrieval = "Retrieval",
        .iterator = "Iterator",
        .collector = "Collector",
        .inline_code = "InlineCode",
        .loop = "Loop",
        .loop_input = "LoopInput",
        .loop_controller = "LoopController",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .input => "Input",
            .output => "Output",
            .knowledge_base => "KnowledgeBase",
            .condition => "Condition",
            .lex => "Lex",
            .prompt => "Prompt",
            .lambda_function => "LambdaFunction",
            .storage => "Storage",
            .agent => "Agent",
            .retrieval => "Retrieval",
            .iterator => "Iterator",
            .collector => "Collector",
            .inline_code => "InlineCode",
            .loop => "Loop",
            .loop_input => "LoopInput",
            .loop_controller => "LoopController",
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
