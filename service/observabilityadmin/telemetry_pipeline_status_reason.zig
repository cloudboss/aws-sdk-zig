/// Provides detailed information about the status of a telemetry pipeline,
/// including reasons for specific states.
pub const TelemetryPipelineStatusReason = struct {
    /// A description of the pipeline status reason, providing additional context
    /// about the current state.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
    };
};
