pub const OutputType = enum {
    /// INT32
    int32,
    /// FLOAT32
    float32,
    /// INT16
    int16,
    /// FLOAT64
    float64,
    /// UINT16
    uint16,

    pub const json_field_names = .{
        .int32 = "INT32",
        .float32 = "FLOAT32",
        .int16 = "INT16",
        .float64 = "FLOAT64",
        .uint16 = "UINT16",
    };
};
