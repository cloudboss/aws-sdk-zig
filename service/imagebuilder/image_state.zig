const ImageStatus = @import("image_status.zig").ImageStatus;

/// Image status and the reason for that status.
pub const ImageState = struct {
    /// The reason for the status of the image.
    reason: ?[]const u8,

    /// The status of the image.
    status: ?ImageStatus,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
