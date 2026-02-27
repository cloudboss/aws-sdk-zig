pub const SampleMode = enum {
    full_dataset,
    custom_rows,

    pub const json_field_names = .{
        .full_dataset = "FULL_DATASET",
        .custom_rows = "CUSTOM_ROWS",
    };
};
