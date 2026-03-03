const VectorData = @import("vector_data.zig").VectorData;

/// The attributes of a vector returned by the `GetVectors` operation.
pub const GetOutputVector = struct {
    /// The vector data of the vector.
    data: ?VectorData = null,

    /// The name of the vector.
    key: []const u8,

    /// Metadata about the vector.
    metadata: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "data",
        .key = "key",
        .metadata = "metadata",
    };
};
