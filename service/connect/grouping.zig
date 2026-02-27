pub const Grouping = enum {
    queue,
    channel,
    routing_profile,
    routing_step_expression,
    agent_status,
    subtype,
    validation_test_type,

    pub const json_field_names = .{
        .queue = "QUEUE",
        .channel = "CHANNEL",
        .routing_profile = "ROUTING_PROFILE",
        .routing_step_expression = "ROUTING_STEP_EXPRESSION",
        .agent_status = "AGENT_STATUS",
        .subtype = "SUBTYPE",
        .validation_test_type = "VALIDATION_TEST_TYPE",
    };
};
