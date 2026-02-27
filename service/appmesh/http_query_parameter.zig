const QueryParameterMatch = @import("query_parameter_match.zig").QueryParameterMatch;

/// An object that represents the query parameter in the request.
pub const HttpQueryParameter = struct {
    /// The query parameter to match on.
    match: ?QueryParameterMatch,

    /// A name for the query parameter that will be matched on.
    name: []const u8,

    pub const json_field_names = .{
        .match = "match",
        .name = "name",
    };
};
