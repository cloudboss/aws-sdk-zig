pub const TemplateStatus = enum {
    created,
    ready,
    pending_creation,
    creating,
    creation_failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .ready = "READY",
        .pending_creation = "PENDING_CREATION",
        .creating = "CREATING",
        .creation_failed = "CREATION_FAILED",
    };
};
