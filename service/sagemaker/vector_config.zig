/// Configuration for your vector collection type.
pub const VectorConfig = struct {
    /// The number of elements in your vector.
    dimension: i32,

    pub const json_field_names = .{
        .dimension = "Dimension",
    };
};
