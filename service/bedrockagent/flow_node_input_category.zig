pub const FlowNodeInputCategory = enum {
    loop_condition,
    return_value_to_loop_start,
    exit_loop,

    pub const json_field_names = .{
        .loop_condition = "LOOP_CONDITION",
        .return_value_to_loop_start = "RETURN_VALUE_TO_LOOP_START",
        .exit_loop = "EXIT_LOOP",
    };
};
