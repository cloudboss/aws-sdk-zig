pub const DocumentStatus = enum {
    received,
    processing,
    indexed,
    updated,
    failed,
    deleting,
    deleted,
    document_failed_to_index,

    pub const json_field_names = .{
        .received = "RECEIVED",
        .processing = "PROCESSING",
        .indexed = "INDEXED",
        .updated = "UPDATED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .document_failed_to_index = "DOCUMENT_FAILED_TO_INDEX",
    };
};
