/// An infrastructure and code recommendation to address a finding.
pub const InfrastructureAndCodeRecommendation = struct {
    /// The list of suggested changes.
    suggested_changes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .suggested_changes = "suggestedChanges",
    };
};
