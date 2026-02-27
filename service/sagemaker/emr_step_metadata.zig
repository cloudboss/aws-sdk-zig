/// The configurations and outcomes of an Amazon EMR step execution.
pub const EMRStepMetadata = struct {
    /// The identifier of the EMR cluster.
    cluster_id: ?[]const u8,

    /// The path to the log file where the cluster step's failure root cause is
    /// recorded.
    log_file_path: ?[]const u8,

    /// The identifier of the EMR cluster step.
    step_id: ?[]const u8,

    /// The name of the EMR cluster step.
    step_name: ?[]const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .log_file_path = "LogFilePath",
        .step_id = "StepId",
        .step_name = "StepName",
    };
};
