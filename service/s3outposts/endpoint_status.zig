pub const EndpointStatus = enum {
    pending,
    available,
    deleting,
    create_failed,
    delete_failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .available = "AVAILABLE",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
    };
};
