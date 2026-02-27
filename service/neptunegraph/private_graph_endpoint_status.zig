pub const PrivateGraphEndpointStatus = enum {
    creating,
    available,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};
