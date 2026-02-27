/// Provides step/procedure step information for a restart batch job operation.
pub const JobStepRestartMarker = struct {
    /// The procedure step name that a batch job was restarted from.
    from_proc_step: ?[]const u8,

    /// The step name that a batch job was restarted from.
    from_step: []const u8,

    /// The step-level checkpoint timestamp (creation or last modification) for an
    /// Amazon Web Services Blu Age application batch job.
    skip: ?bool,

    /// Skip selected step and issue a restart from immediate successor step for an
    /// Amazon Web Services Blu Age application batch job.
    step_checkpoint: ?i32,

    /// The procedure step name that a batch job was restarted to.
    to_proc_step: ?[]const u8,

    /// The step name that a batch job was restarted to.
    to_step: ?[]const u8,

    pub const json_field_names = .{
        .from_proc_step = "fromProcStep",
        .from_step = "fromStep",
        .skip = "skip",
        .step_checkpoint = "stepCheckpoint",
        .to_proc_step = "toProcStep",
        .to_step = "toStep",
    };
};
