/// Content of a recommendation
pub const RecommendationContent = struct {
    /// Agent-ready specification with detailed implementation steps
    spec: ?[]const u8 = null,

    /// A brief summary of the recommendation.
    summary: []const u8,

    pub const json_field_names = .{
        .spec = "spec",
        .summary = "summary",
    };
};
