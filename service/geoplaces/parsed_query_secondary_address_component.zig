/// Information about a secondary address component parsed from the query text.
pub const ParsedQuerySecondaryAddressComponent = struct {
    /// Secondary address designator provided in the query.
    designator: []const u8,

    /// End index of the parsed secondary address component in the query text.
    end_index: i32,

    /// Secondary address number provided in the query.
    number: []const u8,

    /// Start index of the parsed secondary address component in the query text.
    start_index: i32,

    /// Value of the parsed secondary address component.
    value: []const u8,

    pub const json_field_names = .{
        .designator = "Designator",
        .end_index = "EndIndex",
        .number = "Number",
        .start_index = "StartIndex",
        .value = "Value",
    };
};
