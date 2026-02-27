const VectorData = @import("vector_data.zig").VectorData;

/// The attributes of a vector to add to a vector index.
pub const PutInputVector = struct {
    /// The vector data of the vector.
    ///
    /// Vector dimensions must match the dimension count that's configured for the
    /// vector index.
    ///
    /// * For the `cosine` distance metric, zero vectors (vectors containing all
    ///   zeros) aren't allowed.
    /// * For both `cosine` and `euclidean` distance metrics, vector data must
    ///   contain only valid floating-point values. Invalid values such as NaN (Not
    ///   a Number) or Infinity aren't allowed.
    data: VectorData,

    /// The name of the vector. The key uniquely identifies the vector in a vector
    /// index.
    key: []const u8,

    /// Metadata about the vector. All metadata entries undergo validation to ensure
    /// they meet the format requirements for size and data types.
    metadata: ?[]const u8,

    pub const json_field_names = .{
        .data = "data",
        .key = "key",
        .metadata = "metadata",
    };
};
