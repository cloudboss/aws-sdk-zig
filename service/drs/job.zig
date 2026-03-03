const aws = @import("aws");

const InitiatedBy = @import("initiated_by.zig").InitiatedBy;
const ParticipatingResource = @import("participating_resource.zig").ParticipatingResource;
const ParticipatingServer = @import("participating_server.zig").ParticipatingServer;
const JobStatus = @import("job_status.zig").JobStatus;
const JobType = @import("job_type.zig").JobType;

/// A job is an asynchronous workflow.
pub const Job = struct {
    /// The ARN of a Job.
    arn: ?[]const u8 = null,

    /// The date and time of when the Job was created.
    creation_date_time: ?[]const u8 = null,

    /// The date and time of when the Job ended.
    end_date_time: ?[]const u8 = null,

    /// A string representing who initiated the Job.
    initiated_by: ?InitiatedBy = null,

    /// The ID of the Job.
    job_id: []const u8,

    /// A list of resources that the Job is acting upon.
    participating_resources: ?[]const ParticipatingResource = null,

    /// A list of servers that the Job is acting upon.
    participating_servers: ?[]const ParticipatingServer = null,

    /// The status of the Job.
    status: ?JobStatus = null,

    /// A list of tags associated with the Job.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the Job.
    @"type": ?JobType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .end_date_time = "endDateTime",
        .initiated_by = "initiatedBy",
        .job_id = "jobID",
        .participating_resources = "participatingResources",
        .participating_servers = "participatingServers",
        .status = "status",
        .tags = "tags",
        .@"type" = "type",
    };
};
