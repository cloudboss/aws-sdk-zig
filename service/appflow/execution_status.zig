pub const ExecutionStatus = enum {
    inprogress,
    successful,
    @"error",
    cancelstarted,
    canceled,

    pub const json_field_names = .{
        .inprogress = "INPROGRESS",
        .successful = "SUCCESSFUL",
        .@"error" = "ERROR",
        .cancelstarted = "CANCELSTARTED",
        .canceled = "CANCELED",
    };
};
