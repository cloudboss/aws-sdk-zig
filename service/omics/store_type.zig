pub const StoreType = enum {
    sequence_store,
    reference_store,

    pub const json_field_names = .{
        .sequence_store = "SEQUENCE_STORE",
        .reference_store = "REFERENCE_STORE",
    };
};
