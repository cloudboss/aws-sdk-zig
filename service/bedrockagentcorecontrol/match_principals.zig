const MatchPrincipalEntry = @import("match_principal_entry.zig").MatchPrincipalEntry;

/// A condition that matches requests based on the caller's identity.
pub const MatchPrincipals = struct {
    /// A list of principal entries. The condition is met if any of the entries
    /// match the caller's identity.
    any_of: []const MatchPrincipalEntry,

    pub const json_field_names = .{
        .any_of = "anyOf",
    };
};
