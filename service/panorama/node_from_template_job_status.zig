pub const NodeFromTemplateJobStatus = enum {
    pending,
    succeeded,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
