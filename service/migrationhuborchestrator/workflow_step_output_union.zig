/// A structure to hold multiple values of an output.
pub const WorkflowStepOutputUnion = union(enum) {
    /// The integer value.
    integer_value: ?i32,
    /// The list of string value.
    list_of_string_value: ?[]const []const u8,
    /// The string value.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .integer_value = "integerValue",
        .list_of_string_value = "listOfStringValue",
        .string_value = "stringValue",
    };
};
