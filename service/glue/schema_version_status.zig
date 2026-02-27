pub const SchemaVersionStatus = enum {
    available,
    pending,
    failure,
    deleting,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending = "PENDING",
        .failure = "FAILURE",
        .deleting = "DELETING",
    };
};
