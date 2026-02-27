const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// Contains vulnerability counts for a specific image.
pub const ImageAggregation = struct {
    /// The Amazon Resource Name (ARN) that identifies the image for this
    /// aggregation.
    image_build_version_arn: ?[]const u8,

    /// Counts by severity level for medium severity and higher level findings, plus
    /// a total
    /// for all of the findings for the specified image.
    severity_counts: ?SeverityCounts,

    pub const json_field_names = .{
        .image_build_version_arn = "imageBuildVersionArn",
        .severity_counts = "severityCounts",
    };
};
