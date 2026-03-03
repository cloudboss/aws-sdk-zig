const ImageSetState = @import("image_set_state.zig").ImageSetState;
const ImageSetWorkflowStatus = @import("image_set_workflow_status.zig").ImageSetWorkflowStatus;

/// Copy the image set properties of the destination image set.
pub const CopyDestinationImageSetProperties = struct {
    /// The timestamp when the destination image set properties were created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) assigned to the destination image set.
    image_set_arn: ?[]const u8 = null,

    /// The image set identifier of the copied image set properties.
    image_set_id: []const u8,

    /// The image set state of the destination image set properties.
    image_set_state: ?ImageSetState = null,

    /// The image set workflow status of the destination image set properties.
    image_set_workflow_status: ?ImageSetWorkflowStatus = null,

    /// The latest version identifier for the destination image set properties.
    latest_version_id: []const u8,

    /// The timestamp when the destination image set properties were last updated.
    updated_at: ?i64 = null,

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
