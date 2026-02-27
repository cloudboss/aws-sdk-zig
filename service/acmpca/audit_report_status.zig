pub const AuditReportStatus = enum {
    creating,
    success,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .success = "SUCCESS",
        .failed = "FAILED",
    };
};
