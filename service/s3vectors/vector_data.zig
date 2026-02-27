/// The vector data in different formats.
pub const VectorData = union(enum) {
    /// The vector data as 32-bit floating point numbers. The number of elements in
    /// this array must exactly match the dimension of the vector index where the
    /// operation is being performed.
    float_32: ?[]const f32,

    pub const json_field_names = .{
        .float_32 = "float32",
    };
};
