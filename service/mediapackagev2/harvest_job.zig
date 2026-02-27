const Destination = @import("destination.zig").Destination;
const HarvestedManifests = @import("harvested_manifests.zig").HarvestedManifests;
const HarvesterScheduleConfiguration = @import("harvester_schedule_configuration.zig").HarvesterScheduleConfiguration;
const HarvestJobStatus = @import("harvest_job_status.zig").HarvestJobStatus;

/// Represents a harvest job resource in MediaPackage v2, which is used to
/// export content from an origin endpoint to an S3 bucket.
pub const HarvestJob = struct {
    /// The Amazon Resource Name (ARN) of the harvest job.
    arn: []const u8,

    /// The name of the channel group containing the channel associated with this
    /// harvest job.
    channel_group_name: []const u8,

    /// The name of the channel associated with this harvest job.
    channel_name: []const u8,

    /// The date and time when the harvest job was created.
    created_at: i64,

    /// An optional description of the harvest job.
    description: ?[]const u8,

    /// The S3 destination where the harvested content will be placed.
    destination: Destination,

    /// An error message if the harvest job encountered any issues.
    error_message: ?[]const u8,

    /// The current version of the harvest job. Used for concurrency control.
    e_tag: ?[]const u8,

    /// A list of manifests that are being or have been harvested.
    harvested_manifests: HarvestedManifests,

    /// The name of the harvest job.
    harvest_job_name: []const u8,

    /// The date and time when the harvest job was last modified.
    modified_at: i64,

    /// The name of the origin endpoint associated with this harvest job.
    origin_endpoint_name: []const u8,

    /// The configuration for when the harvest job is scheduled to run.
    schedule_configuration: HarvesterScheduleConfiguration,

    /// The current status of the harvest job (e.g., QUEUED, IN_PROGRESS, CANCELLED,
    /// COMPLETED, FAILED).
    status: HarvestJobStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .created_at = "CreatedAt",
        .description = "Description",
        .destination = "Destination",
        .error_message = "ErrorMessage",
        .e_tag = "ETag",
        .harvested_manifests = "HarvestedManifests",
        .harvest_job_name = "HarvestJobName",
        .modified_at = "ModifiedAt",
        .origin_endpoint_name = "OriginEndpointName",
        .schedule_configuration = "ScheduleConfiguration",
        .status = "Status",
    };
};
