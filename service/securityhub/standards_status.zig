pub const StandardsStatus = enum {
    pending,
    ready,
    failed,
    deleting,
    incomplete,

    pub const json_field_names = .{
        .pending = "PENDING",
        .ready = "READY",
        .failed = "FAILED",
        .deleting = "DELETING",
        .incomplete = "INCOMPLETE",
    };
};
