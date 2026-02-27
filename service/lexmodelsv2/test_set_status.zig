pub const TestSetStatus = enum {
    importing,
    pending_annotation,
    deleting,
    validation_error,
    ready,

    pub const json_field_names = .{
        .importing = "Importing",
        .pending_annotation = "PendingAnnotation",
        .deleting = "Deleting",
        .validation_error = "ValidationError",
        .ready = "Ready",
    };
};
