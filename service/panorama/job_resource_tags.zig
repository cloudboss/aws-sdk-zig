const aws = @import("aws");

const JobResourceType = @import("job_resource_type.zig").JobResourceType;

/// Tags for a job.
pub const JobResourceTags = struct {
    /// The job's type.
    resource_type: JobResourceType,

    /// The job's tags.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .tags = "Tags",
    };
};
