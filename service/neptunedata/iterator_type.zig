pub const IteratorType = enum {
    at_sequence_number,
    after_sequence_number,
    trim_horizon,
    latest,

    pub const json_field_names = .{
        .at_sequence_number = "AT_SEQUENCE_NUMBER",
        .after_sequence_number = "AFTER_SEQUENCE_NUMBER",
        .trim_horizon = "TRIM_HORIZON",
        .latest = "LATEST",
    };
};
