const VectorData = @import("vector_data.zig").VectorData;

/// The attributes of a vector returned by the `ListVectors` operation.
pub const ListOutputVector = struct {
    /// The vector data of the vector.
    data: ?VectorData,

    /// The name of the vector.
    key: []const u8,

    /// Metadata about the vector.
    metadata: ?[]const u8,

    pub const json_field_names = .{
        .data = "data",
        .key = "key",
        .metadata = "metadata",
    };
};
