const PathMatchType = @import("path_match_type.zig").PathMatchType;

/// Describes the conditions that can be applied when matching a path for
/// incoming requests.
pub const PathMatch = struct {
    /// Indicates whether the match is case sensitive.
    case_sensitive: ?bool,

    /// The type of path match.
    match: PathMatchType,

    pub const json_field_names = .{
        .case_sensitive = "caseSensitive",
        .match = "match",
    };
};
