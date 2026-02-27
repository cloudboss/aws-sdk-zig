pub const XAxisType = enum {
    iteration_number,
    timestamp,

    pub const json_field_names = .{
        .iteration_number = "ITERATION_NUMBER",
        .timestamp = "TIMESTAMP",
    };
};
