pub const ModelCardProcessingStatus = enum {
    delete_inprogress,
    delete_pending,
    content_deleted,
    exportjobs_deleted,
    delete_completed,
    delete_failed,

    pub const json_field_names = .{
        .delete_inprogress = "DELETE_INPROGRESS",
        .delete_pending = "DELETE_PENDING",
        .content_deleted = "CONTENT_DELETED",
        .exportjobs_deleted = "EXPORTJOBS_DELETED",
        .delete_completed = "DELETE_COMPLETED",
        .delete_failed = "DELETE_FAILED",
    };
};
