const JobResourceType = @import("job_resource_type.zig").JobResourceType;

/// Contains information about a resource that was created or updated by an
/// asynchronous job.
pub const JobResource = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// The identifier of the resource that the job created or updated.
    resource_id: []const u8,

    /// The type of the resource that the job created or updated.
    resource_type: JobResourceType,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};
