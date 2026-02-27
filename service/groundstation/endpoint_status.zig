pub const EndpointStatus = enum {
    created,
    creating,
    deleted,
    deleting,
    failed,

    pub const json_field_names = .{
        .created = "created",
        .creating = "creating",
        .deleted = "deleted",
        .deleting = "deleting",
        .failed = "failed",
    };
};
