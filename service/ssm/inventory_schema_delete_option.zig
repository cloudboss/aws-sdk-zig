pub const InventorySchemaDeleteOption = enum {
    disable_schema,
    delete_schema,

    pub const json_field_names = .{
        .disable_schema = "DISABLE_SCHEMA",
        .delete_schema = "DELETE_SCHEMA",
    };
};
