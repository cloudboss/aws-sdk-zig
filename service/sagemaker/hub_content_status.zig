pub const HubContentStatus = enum {
    available,
    importing,
    deleting,
    import_failed,
    delete_failed,
    pending_import,
    pending_delete,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .importing = "IMPORTING",
        .deleting = "DELETING",
        .import_failed = "IMPORT_FAILED",
        .delete_failed = "DELETE_FAILED",
        .pending_import = "PENDING_IMPORT",
        .pending_delete = "PENDING_DELETE",
    };
};
