pub const locationType = enum {
    ingestion,
    sagemaker,

    pub const json_field_names = .{
        .ingestion = "INGESTION",
        .sagemaker = "SAGEMAKER",
    };
};
