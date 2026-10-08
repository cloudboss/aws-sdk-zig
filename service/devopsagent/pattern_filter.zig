/// A regex-based match condition. Passes when the value matches any pattern.
pub const PatternFilter = struct {
    /// Anchored full-match regex patterns. The condition passes when the value
    /// matches at least one pattern.
    patterns: []const []const u8,

    pub const json_field_names = .{
        .patterns = "patterns",
    };
};
