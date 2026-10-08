/// The expected value used to match a claim. Exactly one member is set.
pub const ClaimMatchValueType = union(enum) {
    /// A single string value to match the claim against.
    match_value_string: ?[]const u8,
    /// A list of string values to match the claim against.
    match_value_string_list: ?[]const []const u8,

    pub const json_field_names = .{
        .match_value_string = "matchValueString",
        .match_value_string_list = "matchValueStringList",
    };
};
