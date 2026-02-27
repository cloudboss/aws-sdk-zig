/// Bedrock models embedding data type. Can be either float32 or binary.
pub const EmbeddingDataType = enum {
    float32,
    binary,

    pub const json_field_names = .{
        .float32 = "FLOAT32",
        .binary = "BINARY",
    };
};
