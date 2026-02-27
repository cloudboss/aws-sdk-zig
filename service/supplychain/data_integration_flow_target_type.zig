pub const DataIntegrationFlowTargetType = enum {
    s3,
    dataset,

    pub const json_field_names = .{
        .s3 = "S3",
        .dataset = "DATASET",
    };
};
