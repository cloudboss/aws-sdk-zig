pub const DataLakeDatasetPartitionTransformType = enum {
    year,
    month,
    day,
    hour,
    identity,

    pub const json_field_names = .{
        .year = "YEAR",
        .month = "MONTH",
        .day = "DAY",
        .hour = "HOUR",
        .identity = "IDENTITY",
    };
};
