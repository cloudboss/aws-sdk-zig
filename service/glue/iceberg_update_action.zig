pub const IcebergUpdateAction = enum {
    add_schema,
    set_current_schema,
    add_spec,
    set_default_spec,
    add_sort_order,
    set_default_sort_order,
    set_location,
    set_properties,
    remove_properties,
    add_encryption_key,
    remove_encryption_key,

    pub const json_field_names = .{
        .add_schema = "ADD_SCHEMA",
        .set_current_schema = "SET_CURRENT_SCHEMA",
        .add_spec = "ADD_SPEC",
        .set_default_spec = "SET_DEFAULT_SPEC",
        .add_sort_order = "ADD_SORT_ORDER",
        .set_default_sort_order = "SET_DEFAULT_SORT_ORDER",
        .set_location = "SET_LOCATION",
        .set_properties = "SET_PROPERTIES",
        .remove_properties = "REMOVE_PROPERTIES",
        .add_encryption_key = "ADD_ENCRYPTION_KEY",
        .remove_encryption_key = "REMOVE_ENCRYPTION_KEY",
    };
};
