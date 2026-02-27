pub const ReadSetStatus = enum {
    archived,
    activating,
    active,
    deleting,
    deleted,
    processing_upload,
    upload_failed,

    pub const json_field_names = .{
        .archived = "ARCHIVED",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .processing_upload = "PROCESSING_UPLOAD",
        .upload_failed = "UPLOAD_FAILED",
    };
};
