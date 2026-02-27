pub const EndpointStatus = enum {
    creating,
    deleting,
    failed,
    in_service,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
        .in_service = "IN_SERVICE",
        .updating = "UPDATING",
    };
};
