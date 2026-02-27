const HttpMatch = @import("http_match.zig").HttpMatch;

/// Describes a rule match.
pub const RuleMatch = union(enum) {
    /// The HTTP criteria that a rule must match.
    http_match: ?HttpMatch,

    pub const json_field_names = .{
        .http_match = "httpMatch",
    };
};
