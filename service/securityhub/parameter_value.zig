/// An object that includes the data type of a security control parameter and
/// its current value.
pub const ParameterValue = union(enum) {
    /// A control parameter that is a boolean.
    boolean: ?bool,
    /// A control parameter that is a double.
    double: ?f64,
    /// A control parameter that is an enum.
    @"enum": ?[]const u8,
    /// A control parameter that is a list of enums.
    enum_list: ?[]const []const u8,
    /// A control parameter that is an integer.
    integer: ?i32,
    /// A control parameter that is a list of integers.
    integer_list: ?[]const i32,
    /// A control parameter that is a string.
    string: ?[]const u8,
    /// A control parameter that is a list of strings.
    string_list: ?[]const []const u8,

    pub const json_field_names = .{
        .boolean = "Boolean",
        .double = "Double",
        .@"enum" = "Enum",
        .enum_list = "EnumList",
        .integer = "Integer",
        .integer_list = "IntegerList",
        .string = "String",
        .string_list = "StringList",
    };
};
