const PreviewStatus = @import("preview_status.zig").PreviewStatus;
const StatusException = @import("status_exception.zig").StatusException;

/// Contains the preview status and preview URL.
pub const Preview = struct {
    /// The status of the preview.
    preview_status: PreviewStatus,

    /// The URL of the preview.
    preview_url: ?[]const u8 = null,

    /// The status exception information.
    status_exception: ?StatusException = null,

    pub const json_field_names = .{
        .preview_status = "PreviewStatus",
        .preview_url = "PreviewUrl",
        .status_exception = "StatusException",
    };
};
