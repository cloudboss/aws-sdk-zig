pub const NodeType = enum {
    flow_input_node,
    flow_output_node,
    lambda_function_node,
    knowledge_base_node,
    prompt_node,
    condition_node,
    lex_node,

    pub const json_field_names = .{
        .flow_input_node = "FLOW_INPUT_NODE",
        .flow_output_node = "FLOW_OUTPUT_NODE",
        .lambda_function_node = "LAMBDA_FUNCTION_NODE",
        .knowledge_base_node = "KNOWLEDGE_BASE_NODE",
        .prompt_node = "PROMPT_NODE",
        .condition_node = "CONDITION_NODE",
        .lex_node = "LEX_NODE",
    };
};
