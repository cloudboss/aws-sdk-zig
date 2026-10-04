const ImageFailureContext = @import("image_failure_context.zig").ImageFailureContext;
const ImageStatus = @import("image_status.zig").ImageStatus;

/// Image status and the reason for that status.
pub const ImageState = struct {
    /// The details about the failure, for images that failed to complete. Image
    /// Builder only
    /// sets this property when the image status is `FAILED`.
    failure_context: ?ImageFailureContext = null,

    /// The reason for the status of the image.
    reason: ?[]const u8 = null,

    /// The status of the image. A new image moves through build, test, and
    /// distribution statuses during creation, and ends in the
    /// `AVAILABLE`, `FAILED`, or `CANCELLED`
    /// state. The `DEPRECATED`, `DISABLED`, and
    /// `DELETED` statuses come from later resource management
    /// actions.
    status: ?ImageStatus = null,

    pub const json_field_names = .{
        .failure_context = "failureContext",
        .reason = "reason",
        .status = "status",
    };
};
