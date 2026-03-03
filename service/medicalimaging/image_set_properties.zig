const ImageSetState = @import("image_set_state.zig").ImageSetState;
const ImageSetWorkflowStatus = @import("image_set_workflow_status.zig").ImageSetWorkflowStatus;
const Overrides = @import("overrides.zig").Overrides;

/// The image set properties.
pub const ImageSetProperties = struct {
    /// The timestamp when the image set properties were created.
    created_at: ?i64 = null,

    /// The timestamp when the image set properties were deleted.
    deleted_at: ?i64 = null,

    /// The image set identifier.
    image_set_id: []const u8,

    /// The image set state.
    image_set_state: ImageSetState,

    /// The image set workflow status.
    image_set_workflow_status: ?ImageSetWorkflowStatus = null,

    /// The flag to determine whether the image set is primary or not.
    is_primary: ?bool = null,

    /// The error message thrown if an image set action fails.
    message: ?[]const u8 = null,

    /// Contains details on overrides used when creating the returned version of an
    /// image set. For example, if `forced` exists, the `forced` flag was used when
    /// creating the image set.
    overrides: ?Overrides = null,

    /// The timestamp when the image set properties were updated.
    updated_at: ?i64 = null,

    /// The image set version identifier.
    version_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .deleted_at = "deletedAt",
        .image_set_id = "imageSetId",
        .image_set_state = "imageSetState",
        .image_set_workflow_status = "ImageSetWorkflowStatus",
        .is_primary = "isPrimary",
        .message = "message",
        .overrides = "overrides",
        .updated_at = "updatedAt",
        .version_id = "versionId",
    };
};
