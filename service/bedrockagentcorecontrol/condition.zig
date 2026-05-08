const MatchPaths = @import("match_paths.zig").MatchPaths;
const MatchPrincipals = @import("match_principals.zig").MatchPrincipals;

/// A condition that determines when a gateway rule applies. Conditions can
/// match on principals or request paths.
pub const Condition = union(enum) {
    /// A condition that matches on the request path.
    match_paths: ?MatchPaths,
    /// A condition that matches on the identity of the caller making the request.
    match_principals: ?MatchPrincipals,

    pub const json_field_names = .{
        .match_paths = "matchPaths",
        .match_principals = "matchPrincipals",
    };
};
