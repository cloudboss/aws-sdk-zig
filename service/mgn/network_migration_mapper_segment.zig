const aws = @import("aws");

const Checksum = @import("checksum.zig").Checksum;
const S3Configuration = @import("s3_configuration.zig").S3Configuration;
const NetworkMigrationMapperSegmentType = @import("network_migration_mapper_segment_type.zig").NetworkMigrationMapperSegmentType;

pub const NetworkMigrationMapperSegment = struct {
    /// The checksum of the segment data for integrity verification.
    checksum: ?Checksum = null,

    /// The timestamp when the segment was created.
    created_at: ?i64 = null,

    /// A description of the segment.
    description: ?[]const u8 = null,

    /// The unique identifier of the job that created this segment.
    job_id: ?[]const u8 = null,

    /// The logical identifier for the segment in the infrastructure code.
    logical_id: ?[]const u8 = null,

    /// The name of the segment.
    name: ?[]const u8 = null,

    /// The unique identifier of the network migration definition.
    network_migration_definition_id: ?[]const u8 = null,

    /// The unique identifier of the network migration execution.
    network_migration_execution_id: ?[]const u8 = null,

    /// The S3 location where segment artifacts are stored.
    output_s3_configuration: ?S3Configuration = null,

    /// A list of other segments that this segment depends on or references.
    referenced_segments: ?[]const []const u8 = null,

    /// Scope tags for the segment.
    scope_tags: ?[]const aws.map.StringMapEntry = null,

    /// The unique identifier of the segment.
    segment_id: ?[]const u8 = null,

    /// The type of the segment, such as VPC, subnet, or security group.
    segment_type: ?NetworkMigrationMapperSegmentType = null,

    /// The target AWS account where this segment will be deployed.
    target_account: ?[]const u8 = null,

    /// The timestamp when the segment was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .checksum = "checksum",
        .created_at = "createdAt",
        .description = "description",
        .job_id = "jobID",
        .logical_id = "logicalID",
        .name = "name",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .network_migration_execution_id = "networkMigrationExecutionID",
        .output_s3_configuration = "outputS3Configuration",
        .referenced_segments = "referencedSegments",
        .scope_tags = "scopeTags",
        .segment_id = "segmentID",
        .segment_type = "segmentType",
        .target_account = "targetAccount",
        .updated_at = "updatedAt",
    };
};
