/// A condition that matches requests based on the request path.
pub const MatchPaths = struct {
    /// A list of path patterns. The condition is met if the request path matches
    /// any of the patterns.
    any_of: []const []const u8,

    pub const json_field_names = .{
        .any_of = "anyOf",
    };
};
