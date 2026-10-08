/// A testing recommendation to address a finding.
pub const TestingRecommendation = struct {
    /// The list of suggested testing changes.
    suggested_changes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .suggested_changes = "suggestedChanges",
    };
};
