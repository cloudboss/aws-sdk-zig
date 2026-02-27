pub const TimeFieldType = enum {
    epoch,
    timestamp_format,

    pub const json_field_names = .{
        .epoch = "EPOCH",
        .timestamp_format = "TIMESTAMP_FORMAT",
    };
};
