/// Parsed components in the provided QueryText.
pub const ParsedQueryComponent = struct {
    /// End index of the parsed query component.
    end_index: ?i32,

    /// The address component that the parsed query component corresponds to.
    query_component: ?[]const u8,

    /// Start index of the parsed query component.
    start_index: ?i32,

    /// Value of the parsed query component.
    value: ?[]const u8,

    pub const json_field_names = .{
        .end_index = "EndIndex",
        .query_component = "QueryComponent",
        .start_index = "StartIndex",
        .value = "Value",
    };
};
