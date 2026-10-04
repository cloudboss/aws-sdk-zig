/// The details of job parameters.
pub const JobParameter = union(enum) {
    /// A boolean value represented as a string. Accepted values are `true`,
    /// `false`, `yes`, `no`, `on`, `off`, `1`, and `0`, case-insensitive.
    bool: ?[]const u8,
    /// A list of boolean values, each represented as a string.
    bool_list: ?[]const []const u8,
    /// A double precision IEEE-754 floating point number represented as a string.
    float: ?[]const u8,
    /// A list of double precision IEEE-754 floating point numbers, each represented
    /// as a string.
    float_list: ?[]const []const u8,
    /// A signed integer represented as a string.
    int: ?[]const u8,
    /// A list of signed integers, each represented as a string.
    int_list: ?[]const []const u8,
    /// A list of lists of signed integers, each represented as a string.
    int_list_list: ?[]const []const []const u8,
    /// A file system path represented as a string.
    path: ?[]const u8,
    /// A list of file system paths, each represented as a string.
    path_list: ?[]const []const u8,
    /// An Open Job Description range expression represented as a string, such as
    /// `1-10:2`.
    range_expr: ?[]const u8,
    /// A UTF-8 string.
    string: ?[]const u8,
    /// A list of UTF-8 strings.
    string_list: ?[]const []const u8,

    pub const json_field_names = .{
        .bool = "bool",
        .bool_list = "boolList",
        .float = "float",
        .float_list = "floatList",
        .int = "int",
        .int_list = "intList",
        .int_list_list = "intListList",
        .path = "path",
        .path_list = "pathList",
        .range_expr = "rangeExpr",
        .string = "string",
        .string_list = "stringList",
    };
};
