const ExportDestination = @import("export_destination.zig").ExportDestination;
const ResourceType = @import("resource_type.zig").ResourceType;
const JobStatus = @import("job_status.zig").JobStatus;

/// Describes a recommendation export job.
///
/// Use the DescribeRecommendationExportJobs action to view your
/// recommendation export jobs.
///
/// Use the ExportAutoScalingGroupRecommendations or
/// ExportEC2InstanceRecommendations actions to request an export of your
/// recommendations.
pub const RecommendationExportJob = struct {
    /// The timestamp of when the export job was created.
    creation_timestamp: ?i64,

    /// An object that describes the destination of the export file.
    destination: ?ExportDestination,

    /// The reason for an export job failure.
    failure_reason: ?[]const u8,

    /// The identification number of the export job.
    job_id: ?[]const u8,

    /// The timestamp of when the export job was last updated.
    last_updated_timestamp: ?i64,

    /// The resource type of the exported recommendations.
    resource_type: ?ResourceType,

    /// The status of the export job.
    status: ?JobStatus,

    pub const json_field_names = .{
        .creation_timestamp = "creationTimestamp",
        .destination = "destination",
        .failure_reason = "failureReason",
        .job_id = "jobId",
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .resource_type = "resourceType",
        .status = "status",
    };
};
