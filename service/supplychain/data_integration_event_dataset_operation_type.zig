pub const DataIntegrationEventDatasetOperationType = enum {
    append,
    upsert,
    delete,

    pub const json_field_names = .{
        .append = "APPEND",
        .upsert = "UPSERT",
        .delete = "DELETE",
    };
};
