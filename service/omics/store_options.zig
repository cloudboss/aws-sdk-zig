const TsvStoreOptions = @import("tsv_store_options.zig").TsvStoreOptions;

/// Settings for a store.
pub const StoreOptions = union(enum) {
    /// File settings for a TSV store.
    tsv_store_options: ?TsvStoreOptions,

    pub const json_field_names = .{
        .tsv_store_options = "tsvStoreOptions",
    };
};
