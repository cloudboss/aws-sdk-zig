pub const ConnectionState = enum {
    pending,
    available,
    deleting,
    updating,

    pub const json_field_names = .{
        .pending = "pending",
        .available = "available",
        .deleting = "deleting",
        .updating = "updating",
    };
};
