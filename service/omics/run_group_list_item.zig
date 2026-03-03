/// A run group.
pub const RunGroupListItem = struct {
    /// The group's ARN.
    arn: ?[]const u8 = null,

    /// When the group was created.
    creation_time: ?i64 = null,

    /// The group's ID.
    id: ?[]const u8 = null,

    /// The group's maximum CPU count setting.
    max_cpus: ?i32 = null,

    /// The group's maximum duration setting in minutes.
    max_duration: ?i32 = null,

    /// The maximum GPUs that can be used by a run group.
    max_gpus: ?i32 = null,

    /// The group's maximum concurrent run setting.
    max_runs: ?i32 = null,

    /// The group's name.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .id = "id",
        .max_cpus = "maxCpus",
        .max_duration = "maxDuration",
        .max_gpus = "maxGpus",
        .max_runs = "maxRuns",
        .name = "name",
    };
};
