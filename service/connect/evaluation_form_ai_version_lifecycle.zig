const EvaluationFormAIVersionStatus = @import("evaluation_form_ai_version_status.zig").EvaluationFormAIVersionStatus;

/// Contains the status and availability dates for an AI version, indicating
/// when the version became active and when it reaches end of life.
pub const EvaluationFormAIVersionLifecycle = struct {
    /// The timestamp when this AI version reaches or reached end of life.
    end_of_life_time: ?i64 = null,

    /// The timestamp for when this AI version became available.
    start_of_life_time: i64,

    /// The status of the AI version. Valid values:
    ///
    /// * `Latest` - The most recent AI version.
    ///
    /// * `Preview` - An AI version available for preview.
    ///
    /// * `Active` - An AI version that is currently available.
    ///
    /// * `Deprecated` - An AI version that is no longer recommended for use.
    ///
    /// * `Removed` - An AI version that is no longer available.
    status: EvaluationFormAIVersionStatus,

    pub const json_field_names = .{
        .end_of_life_time = "EndOfLifeTime",
        .start_of_life_time = "StartOfLifeTime",
        .status = "Status",
    };
};
