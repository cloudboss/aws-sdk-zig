pub const AttachmentStatus = enum {
    creating,
    deleting,
    failed,
    @"error",
    scaling,
    ready,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .@"error" = "ERROR",
        .scaling = "SCALING",
        .ready = "READY",
    };
};
