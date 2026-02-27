pub const StepParameterType = enum {
    int,
    float,
    string,
    path,
    chunk_int,

    pub const json_field_names = .{
        .int = "INT",
        .float = "FLOAT",
        .string = "STRING",
        .path = "PATH",
        .chunk_int = "CHUNK_INT",
    };
};
