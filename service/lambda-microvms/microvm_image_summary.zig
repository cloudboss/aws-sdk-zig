const MicrovmImageState = @import("microvm_image_state.zig").MicrovmImageState;

/// Contains summary information about a MicroVM image.
pub const MicrovmImageSummary = struct {
    /// The timestamp when the MicroVM image was created.
    created_at: i64,

    /// The ARN of the MicroVM image.
    image_arn: []const u8,

    /// The latest active version of the MicroVM image.
    latest_active_image_version: ?[]const u8 = null,

    /// The latest failed version of the MicroVM image, if any.
    latest_failed_image_version: ?[]const u8 = null,

    /// The name of the MicroVM image.
    name: []const u8,

    /// The current state of the MicroVM image.
    state: MicrovmImageState,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .image_arn = "imageArn",
        .latest_active_image_version = "latestActiveImageVersion",
        .latest_failed_image_version = "latestFailedImageVersion",
        .name = "name",
        .state = "state",
    };
};
