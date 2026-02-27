const aws = @import("aws");

const EarthObservationJobStatus = @import("earth_observation_job_status.zig").EarthObservationJobStatus;

/// An object containing information about the output file.
pub const ListEarthObservationJobOutputConfig = struct {
    /// The Amazon Resource Name (ARN) of the list of the Earth Observation jobs.
    arn: []const u8,

    /// The creation time.
    creation_time: i64,

    /// The duration of the session, in seconds.
    duration_in_seconds: i32,

    /// The names of the Earth Observation jobs in the list.
    name: []const u8,

    /// The operation type for an Earth Observation job.
    operation_type: []const u8,

    /// The status of the list of the Earth Observation jobs.
    status: EarthObservationJobStatus,

    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .duration_in_seconds = "DurationInSeconds",
        .name = "Name",
        .operation_type = "OperationType",
        .status = "Status",
        .tags = "Tags",
    };
};
