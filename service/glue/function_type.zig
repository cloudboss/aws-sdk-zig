pub const FunctionType = enum {
    regular_function,
    aggregate_function,
    stored_procedure,

    pub const json_field_names = .{
        .regular_function = "REGULAR_FUNCTION",
        .aggregate_function = "AGGREGATE_FUNCTION",
        .stored_procedure = "STORED_PROCEDURE",
    };
};
