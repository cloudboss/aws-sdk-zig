pub const ShardIteratorType = enum {
    trim_horizon,
    latest,
    at_sequence_number,
    after_sequence_number,

    pub const json_field_names = .{
        .trim_horizon = "TRIM_HORIZON",
        .latest = "LATEST",
        .at_sequence_number = "AT_SEQUENCE_NUMBER",
        .after_sequence_number = "AFTER_SEQUENCE_NUMBER",
    };
};
