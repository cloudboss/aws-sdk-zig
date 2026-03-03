const HeaderMatch = @import("header_match.zig").HeaderMatch;
const PathMatch = @import("path_match.zig").PathMatch;

/// Describes criteria that can be applied to incoming requests.
pub const HttpMatch = struct {
    /// The header matches. Matches incoming requests with rule based on request
    /// header value before applying rule action.
    header_matches: ?[]const HeaderMatch = null,

    /// The HTTP method type.
    method: ?[]const u8 = null,

    /// The path match.
    path_match: ?PathMatch = null,

    pub const json_field_names = .{
        .header_matches = "headerMatches",
        .method = "method",
        .path_match = "pathMatch",
    };
};
