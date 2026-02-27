pub const ICD10CMEntityType = enum {
    dx_name,
    time_expression,

    pub const json_field_names = .{
        .dx_name = "DX_NAME",
        .time_expression = "TIME_EXPRESSION",
    };
};
