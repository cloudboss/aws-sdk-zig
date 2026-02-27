pub const EvaluationState = enum {
    partial_data,

    pub const json_field_names = .{
        .partial_data = "PARTIAL_DATA",
    };
};
