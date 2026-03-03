/// Filter for pipeline executions that have successfully completed the stage in
/// the
/// current pipeline version.
pub const SucceededInStageFilter = struct {
    /// The name of the stage for filtering for pipeline executions where the stage
    /// was
    /// successful in the current pipeline version.
    stage_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .stage_name = "stageName",
    };
};
