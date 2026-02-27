const LabelCountersForWorkteam = @import("label_counters_for_workteam.zig").LabelCountersForWorkteam;

/// Provides summary information for a work team.
pub const LabelingJobForWorkteamSummary = struct {
    /// The date and time that the labeling job was created.
    creation_time: i64,

    /// A unique identifier for a labeling job. You can use this to refer to a
    /// specific labeling job.
    job_reference_code: []const u8,

    /// Provides information about the progress of a labeling job.
    label_counters: ?LabelCountersForWorkteam,

    /// The name of the labeling job that the work team is assigned to.
    labeling_job_name: ?[]const u8,

    /// The configured number of workers per data object.
    number_of_human_workers_per_data_object: ?i32,

    /// The Amazon Web Services account ID of the account used to start the labeling
    /// job.
    work_requester_account_id: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .job_reference_code = "JobReferenceCode",
        .label_counters = "LabelCounters",
        .labeling_job_name = "LabelingJobName",
        .number_of_human_workers_per_data_object = "NumberOfHumanWorkersPerDataObject",
        .work_requester_account_id = "WorkRequesterAccountId",
    };
};
