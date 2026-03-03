const JobState = @import("job_state.zig").JobState;
const JobType = @import("job_type.zig").JobType;
const SnowballType = @import("snowball_type.zig").SnowballType;

/// Each `JobListEntry` object contains a job's state, a job's ID, and a value
/// that indicates whether the job is a job part, in the case of an export job.
pub const JobListEntry = struct {
    /// The creation date for this job.
    creation_date: ?i64 = null,

    /// The optional description of this specific job, for example `Important Photos
    /// 2016-08-11`.
    description: ?[]const u8 = null,

    /// A value that indicates that this job is a main job. A main job represents a
    /// successful
    /// request to create an export job. Main jobs aren't associated with any
    /// Snowballs. Instead, each
    /// main job will have at least one job part, and each job part is associated
    /// with a Snowball. It
    /// might take some time before the job parts associated with a particular main
    /// job are listed,
    /// because they are created after the main job is created.
    is_master: bool = false,

    /// The automatically generated ID for a job, for example
    /// `JID123e4567-e89b-12d3-a456-426655440000`.
    job_id: ?[]const u8 = null,

    /// The current state of this job.
    job_state: ?JobState = null,

    /// The type of job.
    job_type: ?JobType = null,

    /// The type of device used with this job.
    snowball_type: ?SnowballType = null,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .description = "Description",
        .is_master = "IsMaster",
        .job_id = "JobId",
        .job_state = "JobState",
        .job_type = "JobType",
        .snowball_type = "SnowballType",
    };
};
