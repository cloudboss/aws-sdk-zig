const ImageSetState = @import("image_set_state.zig").ImageSetState;
const ImageSetWorkflowStatus = @import("image_set_workflow_status.zig").ImageSetWorkflowStatus;

/// Copy source image set properties.
pub const CopySourceImageSetProperties = struct {
    /// The timestamp when the source image set properties were created.
    created_at: ?i64,

    /// The Amazon Resource Name (ARN) assigned to the source image set.
    image_set_arn: ?[]const u8,

    /// The image set identifier for the copied source image set.
    image_set_id: []const u8,

    /// The image set state of the copied source image set.
    image_set_state: ?ImageSetState,

    /// The workflow status of the copied source image set.
    image_set_workflow_status: ?ImageSetWorkflowStatus,

    /// The latest version identifier for the copied source image set.
    latest_version_id: []const u8,

    /// The timestamp when the source image set properties were updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .image_set_arn = "imageSetArn",
        .image_set_id = "imageSetId",
        .image_set_state = "imageSetState",
        .image_set_workflow_status = "imageSetWorkflowStatus",
        .latest_version_id = "latestVersionId",
        .updated_at = "updatedAt",
    };
};
