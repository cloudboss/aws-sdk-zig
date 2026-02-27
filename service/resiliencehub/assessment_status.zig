pub const AssessmentStatus = enum {
    pending,
    inprogress,
    failed,
    success,

    pub const json_field_names = .{
        .pending = "PENDING",
        .inprogress = "INPROGRESS",
        .failed = "FAILED",
        .success = "SUCCESS",
    };
};
