pub const StorageType = enum {
    sitewise_default_storage,
    multi_layer_storage,

    pub const json_field_names = .{
        .sitewise_default_storage = "SITEWISE_DEFAULT_STORAGE",
        .multi_layer_storage = "MULTI_LAYER_STORAGE",
    };
};
