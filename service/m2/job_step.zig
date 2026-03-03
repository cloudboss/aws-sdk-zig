/// Provides information related to a job step.
pub const JobStep = struct {
    /// The name of a procedure step.
    proc_step_name: ?[]const u8 = null,

    /// The number of a procedure step.
    proc_step_number: i32 = 0,

    /// A registered step-level checkpoint identifier that can be used for
    /// restarting an Amazon Web Services Blu Age application batch job.
    step_checkpoint: ?i32 = null,

    /// The step-level checkpoint status for an Amazon Web Services Blu Age
    /// application batch job.
    step_checkpoint_status: ?[]const u8 = null,

    /// The step-level checkpoint status for an Amazon Web Services Blu Age
    /// application batch job.
    step_checkpoint_time: ?i64 = null,

    /// The condition code of a step.
    step_cond_code: ?[]const u8 = null,

    /// The name of a step.
    step_name: ?[]const u8 = null,

    /// The number of a step.
    step_number: i32 = 0,

    /// Specifies if a step can be restarted or not.
    step_restartable: bool = false,

    pub const json_field_names = .{
        .proc_step_name = "procStepName",
        .proc_step_number = "procStepNumber",
        .step_checkpoint = "stepCheckpoint",
        .step_checkpoint_status = "stepCheckpointStatus",
        .step_checkpoint_time = "stepCheckpointTime",
        .step_cond_code = "stepCondCode",
        .step_name = "stepName",
        .step_number = "stepNumber",
        .step_restartable = "stepRestartable",
    };
};
