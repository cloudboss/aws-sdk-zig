/// The value or values to match for.
///
/// * Include a `matchValueString` with the `EQUALS` operator to specify a
///   string that matches the claim field value.
/// * Include a `matchValueArray` to specify an array of string values. You can
///   use the following operators:
///
/// * Use `CONTAINS` to yield a match if the claim field value is in the array.
/// * Use `CONTAINS_ANY` to yield a match if the claim field value contains any
///   of the strings in the array.
pub const ClaimMatchValueType = union(enum) {
    /// The string value to match for.
    match_value_string: ?[]const u8,
    /// An array of strings to check for a match.
    match_value_string_list: ?[]const []const u8,

    pub const json_field_names = .{
        .match_value_string = "matchValueString",
        .match_value_string_list = "matchValueStringList",
    };
};
