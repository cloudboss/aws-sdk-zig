pub const AuditCheckRunStatus = enum {
    in_progress,
    waiting_for_data_collection,
    canceled,
    completed_compliant,
    completed_non_compliant,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .waiting_for_data_collection = "WAITING_FOR_DATA_COLLECTION",
        .canceled = "CANCELED",
        .completed_compliant = "COMPLETED_COMPLIANT",
        .completed_non_compliant = "COMPLETED_NON_COMPLIANT",
        .failed = "FAILED",
    };
};
