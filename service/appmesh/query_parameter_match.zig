/// An object representing the query parameter to match.
pub const QueryParameterMatch = struct {
    /// The exact query parameter to match on.
    exact: ?[]const u8,

    pub const json_field_names = .{
        .exact = "exact",
    };
};
