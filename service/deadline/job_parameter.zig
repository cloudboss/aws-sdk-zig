/// The details of job parameters.
pub const JobParameter = union(enum) {
    /// A double precision IEEE-754 floating point number represented as a string.
    float: ?[]const u8,
    /// A signed integer represented as a string.
    int: ?[]const u8,
    /// A file system path represented as a string.
    path: ?[]const u8,
    /// A UTF-8 string.
    string: ?[]const u8,

    pub const json_field_names = .{
        .float = "float",
        .int = "int",
        .path = "path",
        .string = "string",
    };
};
