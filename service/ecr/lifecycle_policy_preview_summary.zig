const TransitioningImageTotalCount = @import("transitioning_image_total_count.zig").TransitioningImageTotalCount;

/// The summary of the lifecycle policy preview request.
pub const LifecyclePolicyPreviewSummary = struct {
    /// The number of expiring images.
    expiring_image_total_count: ?i32 = null,

    /// The total count of images that will be transitioned to each storage class.
    /// This field is only present if at least one image will be transitoned in the
    /// summary.
    transitioning_image_total_counts: ?[]const TransitioningImageTotalCount = null,

    pub const json_field_names = .{
        .expiring_image_total_count = "expiringImageTotalCount",
        .transitioning_image_total_counts = "transitioningImageTotalCounts",
    };
};
