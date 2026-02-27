/// A nested application summary.
pub const ApplicationDependencySummary = struct {
    /// The Amazon Resource Name (ARN) of the nested application.
    application_id: []const u8,

    /// The semantic version of the nested application.
    semantic_version: []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .semantic_version = "SemanticVersion",
    };
};
