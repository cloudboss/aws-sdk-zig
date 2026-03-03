const AccountAggregation = @import("account_aggregation.zig").AccountAggregation;
const ImageAggregation = @import("image_aggregation.zig").ImageAggregation;
const ImagePipelineAggregation = @import("image_pipeline_aggregation.zig").ImagePipelineAggregation;
const VulnerabilityIdAggregation = @import("vulnerability_id_aggregation.zig").VulnerabilityIdAggregation;

/// This returns exactly one type of aggregation, based on the filter that Image
/// Builder applies in
/// its API action.
pub const ImageScanFindingAggregation = struct {
    /// Returns an object that contains severity counts based on an account ID.
    account_aggregation: ?AccountAggregation = null,

    /// Returns an object that contains severity counts based on the Amazon Resource
    /// Name (ARN) for a specific image.
    image_aggregation: ?ImageAggregation = null,

    /// Returns an object that contains severity counts based on an image pipeline
    /// ARN.
    image_pipeline_aggregation: ?ImagePipelineAggregation = null,

    /// Returns an object that contains severity counts based on vulnerability ID.
    vulnerability_id_aggregation: ?VulnerabilityIdAggregation = null,

    pub const json_field_names = .{
        .account_aggregation = "accountAggregation",
        .image_aggregation = "imageAggregation",
        .image_pipeline_aggregation = "imagePipelineAggregation",
        .vulnerability_id_aggregation = "vulnerabilityIdAggregation",
    };
};
