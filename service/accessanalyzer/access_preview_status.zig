pub const AccessPreviewStatus = enum {
    completed,
    creating,
    failed,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .creating = "CREATING",
        .failed = "FAILED",
    };
};
