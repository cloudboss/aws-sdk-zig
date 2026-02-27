/// This structure assigns a feature variation to one user session.
pub const EvaluationRequest = struct {
    /// An internal ID that represents a unique user session of the application.
    /// This `entityID` is checked against any override rules assigned for this
    /// feature.
    entity_id: []const u8,

    /// A JSON block of attributes that you can optionally pass in. This JSON block
    /// is included in the evaluation events sent to Evidently from the user
    /// session.
    evaluation_context: ?[]const u8,

    /// The name of the feature being evaluated.
    feature: []const u8,

    pub const json_field_names = .{
        .entity_id = "entityId",
        .evaluation_context = "evaluationContext",
        .feature = "feature",
    };
};
