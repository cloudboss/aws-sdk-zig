const aws = @import("aws");

/// A map of key value pairs that is generated when you create a migration
/// workflow. The
/// key value pairs will differ based on your selection of the template.
pub const StepInput = union(enum) {
    /// The value of the integer.
    integer_value: ?i32,
    /// List of string values.
    list_of_strings_value: ?[]const []const u8,
    /// Map of string values.
    map_of_string_value: ?[]const aws.map.StringMapEntry,
    /// String value.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .integer_value = "integerValue",
        .list_of_strings_value = "listOfStringsValue",
        .map_of_string_value = "mapOfStringValue",
        .string_value = "stringValue",
    };
};
