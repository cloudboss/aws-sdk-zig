const SupplementaryFeature = @import("supplementary_feature.zig").SupplementaryFeature;

/// This object belongs to the CreatePredictor operation. If you created
/// your predictor with CreateAutoPredictor, see DataConfig.
///
/// The data used to train a predictor. The data includes a dataset group and
/// any
/// supplementary features. You specify this object in the CreatePredictor
/// request.
pub const InputDataConfig = struct {
    /// The Amazon Resource Name (ARN) of the dataset group.
    dataset_group_arn: []const u8,

    /// An array of supplementary features. The only supported feature is a holiday
    /// calendar.
    supplementary_features: ?[]const SupplementaryFeature = null,

    pub const json_field_names = .{
        .dataset_group_arn = "DatasetGroupArn",
        .supplementary_features = "SupplementaryFeatures",
    };
};
