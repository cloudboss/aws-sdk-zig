const TagStatus = @import("tag_status.zig").TagStatus;

/// The filter for the lifecycle policy preview.
pub const LifecyclePolicyPreviewFilter = struct {
    /// The tag status of the image.
    tag_status: ?TagStatus = null,

    pub const json_field_names = .{
        .tag_status = "tagStatus",
    };
};
