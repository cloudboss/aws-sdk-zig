const aws = @import("aws");

const InitiatedBy = @import("initiated_by.zig").InitiatedBy;
const ParticipatingServer = @import("participating_server.zig").ParticipatingServer;
const JobStatus = @import("job_status.zig").JobStatus;
const JobType = @import("job_type.zig").JobType;

/// Job.
pub const Job = struct {
    /// the ARN of the specific Job.
    arn: ?[]const u8 = null,

    /// Job creation time.
    creation_date_time: ?[]const u8 = null,

    /// Job end time.
    end_date_time: ?[]const u8 = null,

    /// Job initiated by field.
    initiated_by: ?InitiatedBy = null,

    /// Job ID.
    job_id: []const u8,

    /// Servers participating in a specific Job.
    participating_servers: ?[]const ParticipatingServer = null,

    /// Job status.
    status: ?JobStatus = null,

    /// Tags associated with specific Job.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Job type.
    @"type": ?JobType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .end_date_time = "endDateTime",
        .initiated_by = "initiatedBy",
        .job_id = "jobID",
        .participating_servers = "participatingServers",
        .status = "status",
        .tags = "tags",
        .@"type" = "type",
    };
};
