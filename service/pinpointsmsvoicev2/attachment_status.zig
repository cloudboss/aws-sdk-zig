pub const AttachmentStatus = enum {
    upload_in_progress,
    upload_complete,
    upload_failed,
    deleted,

    pub const json_field_names = .{
        .upload_in_progress = "UPLOAD_IN_PROGRESS",
        .upload_complete = "UPLOAD_COMPLETE",
        .upload_failed = "UPLOAD_FAILED",
        .deleted = "DELETED",
    };
};
