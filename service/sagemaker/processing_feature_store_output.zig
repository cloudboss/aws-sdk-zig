/// Configuration for processing job outputs in Amazon SageMaker Feature Store.
pub const ProcessingFeatureStoreOutput = struct {
    /// The name of the Amazon SageMaker FeatureGroup to use as the destination for
    /// processing job output. Note that your processing script is responsible for
    /// putting records into your Feature Store.
    feature_group_name: []const u8,

    pub const json_field_names = .{
        .feature_group_name = "FeatureGroupName",
    };
};
