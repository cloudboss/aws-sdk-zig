const HeaderMatchType = @import("header_match_type.zig").HeaderMatchType;

/// Describes the constraints for a header match. Matches incoming requests with
/// rule based on request header value before applying rule action.
pub const HeaderMatch = struct {
    /// Indicates whether the match is case sensitive.
    case_sensitive: ?bool,

    /// The header match type.
    match: HeaderMatchType,

    /// The name of the header.
    name: []const u8,

    pub const json_field_names = .{
        .case_sensitive = "caseSensitive",
        .match = "match",
        .name = "name",
    };
};
