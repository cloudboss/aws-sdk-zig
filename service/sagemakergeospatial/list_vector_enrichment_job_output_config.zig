const aws = @import("aws");

const VectorEnrichmentJobStatus = @import("vector_enrichment_job_status.zig").VectorEnrichmentJobStatus;
const VectorEnrichmentJobType = @import("vector_enrichment_job_type.zig").VectorEnrichmentJobType;

/// An object containing information about the output file.
pub const ListVectorEnrichmentJobOutputConfig = struct {
    /// The Amazon Resource Name (ARN) of the list of the Vector Enrichment jobs.
    arn: []const u8,

    /// The creation time.
    creation_time: i64,

    /// The duration of the session, in seconds.
    duration_in_seconds: i32,

    /// The names of the Vector Enrichment jobs in the list.
    name: []const u8,

    /// The status of the Vector Enrichment jobs list.
    status: VectorEnrichmentJobStatus,

    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry,

    /// The type of the list of Vector Enrichment jobs.
    type: VectorEnrichmentJobType,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .duration_in_seconds = "DurationInSeconds",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .type = "Type",
    };
};
