pub const DocumentStatus = enum {
    not_found,
    processing,
    indexed,
    updated,
    failed,
    update_failed,

    pub const json_field_names = .{
        .not_found = "NOT_FOUND",
        .processing = "PROCESSING",
        .indexed = "INDEXED",
        .updated = "UPDATED",
        .failed = "FAILED",
        .update_failed = "UPDATE_FAILED",
    };
};
