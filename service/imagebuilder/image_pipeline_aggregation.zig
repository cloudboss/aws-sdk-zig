const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// Contains vulnerability counts for a specific image pipeline.
pub const ImagePipelineAggregation = struct {
    /// The Amazon Resource Name (ARN) that identifies the image pipeline for this
    /// aggregation.
    image_pipeline_arn: ?[]const u8,

    /// Counts by severity level for medium severity and higher level findings, plus
    /// a total
    /// for all of the findings for the specified image pipeline.
    severity_counts: ?SeverityCounts,

    pub const json_field_names = .{
        .image_pipeline_arn = "imagePipelineArn",
        .severity_counts = "severityCounts",
    };
};
