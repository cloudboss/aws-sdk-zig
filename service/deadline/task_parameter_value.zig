/// The data types for the task parameters.
pub const TaskParameterValue = union(enum) {
    /// A range (for example 1-10) or selection of specific (for example 1,3,7,8,10)
    /// integers represented as a string.
    chunk_int: ?[]const u8,
    /// A double precision IEEE-754 floating point number represented as a string.
    float: ?[]const u8,
    /// A signed integer represented as a string.
    int: ?[]const u8,
    /// A file system path represented as a string.
    path: ?[]const u8,
    /// A UTF-8 string.
    string: ?[]const u8,

    pub const json_field_names = .{
        .chunk_int = "chunkInt",
        .float = "float",
        .int = "int",
        .path = "path",
        .string = "string",
    };
};
