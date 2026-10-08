/// An observability recommendation to address a finding.
pub const ObservabilityRecommendation = struct {
    /// The list of suggested observability changes.
    suggested_changes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .suggested_changes = "suggestedChanges",
    };
};
