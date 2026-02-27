pub const DocumentStatus = enum {
    indexed,
    partially_indexed,
    pending,
    failed,
    metadata_partially_indexed,
    metadata_update_failed,
    ignored,
    not_found,
    starting,
    in_progress,
    deleting,
    delete_in_progress,

    pub const json_field_names = .{
        .indexed = "INDEXED",
        .partially_indexed = "PARTIALLY_INDEXED",
        .pending = "PENDING",
        .failed = "FAILED",
        .metadata_partially_indexed = "METADATA_PARTIALLY_INDEXED",
        .metadata_update_failed = "METADATA_UPDATE_FAILED",
        .ignored = "IGNORED",
        .not_found = "NOT_FOUND",
        .starting = "STARTING",
        .in_progress = "IN_PROGRESS",
        .deleting = "DELETING",
        .delete_in_progress = "DELETE_IN_PROGRESS",
    };
};
