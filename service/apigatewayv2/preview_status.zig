/// Represents the preview status.
pub const PreviewStatus = enum {
    preview_in_progress,
    preview_failed,
    preview_ready,

    pub const json_field_names = .{
        .preview_in_progress = "PREVIEW_IN_PROGRESS",
        .preview_failed = "PREVIEW_FAILED",
        .preview_ready = "PREVIEW_READY",
    };
};
