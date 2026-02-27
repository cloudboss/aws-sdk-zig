/// Specifies the number of dimensions for vector embeddings loaded into the
/// graph. Max = 65535
pub const VectorSearchConfiguration = struct {
    /// The number of dimensions.
    dimension: i32,

    pub const json_field_names = .{
        .dimension = "dimension",
    };
};
