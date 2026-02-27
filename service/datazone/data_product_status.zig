pub const DataProductStatus = enum {
    created,
    creating,
    create_failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
    };
};
