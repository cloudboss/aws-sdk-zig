pub const ReportStatusType = enum {
    generating,
    succeeded,
    failed,
    incomplete,
    deleting,

    pub const json_field_names = .{
        .generating = "GENERATING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .incomplete = "INCOMPLETE",
        .deleting = "DELETING",
    };
};
