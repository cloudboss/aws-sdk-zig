pub const DynamoDBStreamStartPosition = enum {
    trim_horizon,
    latest,

    pub const json_field_names = .{
        .trim_horizon = "TRIM_HORIZON",
        .latest = "LATEST",
    };
};
