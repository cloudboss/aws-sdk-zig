const S3Object = @import("s3_object.zig").S3Object;

/// Blueprint Recommendation Sample
pub const BlueprintOptimizationSample = struct {
    /// S3 Object of the asset
    asset_s3_object: S3Object,

    /// Ground truth for the Blueprint and Asset combination
    ground_truth_s3_object: S3Object,

    pub const json_field_names = .{
        .asset_s3_object = "assetS3Object",
        .ground_truth_s3_object = "groundTruthS3Object",
    };
};
