const VectorConfig = @import("vector_config.zig").VectorConfig;

/// Configuration for your collection.
pub const CollectionConfig = union(enum) {
    /// Configuration for your vector collection type.
    ///
    /// * `Dimension`: The number of elements in your vector.
    vector_config: ?VectorConfig,

    pub const json_field_names = .{
        .vector_config = "VectorConfig",
    };
};
