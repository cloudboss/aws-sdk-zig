const NetworkMigrationCodeGenerationArtifact = @import("network_migration_code_generation_artifact.zig").NetworkMigrationCodeGenerationArtifact;
const NetworkMigrationCodeGenerationSegmentType = @import("network_migration_code_generation_segment_type.zig").NetworkMigrationCodeGenerationSegmentType;

/// A segment of generated code representing a logical grouping of
/// infrastructure resources.
pub const NetworkMigrationCodeGenerationSegment = struct {
    /// A list of artifacts generated for this segment.
    artifacts: ?[]const NetworkMigrationCodeGenerationArtifact = null,

    /// The timestamp when the segment was created.
    created_at: ?i64 = null,

    /// The unique identifier of the code generation job.
    job_id: ?[]const u8 = null,

    /// The logical identifier for the segment.
    logical_id: ?[]const u8 = null,

    /// The ID of the mapper segment that this code generation segment was created
    /// from.
    mapper_segment_id: ?[]const u8 = null,

    /// The unique identifier of the network migration definition.
    network_migration_definition_id: ?[]const u8 = null,

    /// The unique identifier of the network migration execution.
    network_migration_execution_id: ?[]const u8 = null,

    /// The unique identifier of the segment.
    segment_id: ?[]const u8 = null,

    /// The type of the segment.
    segment_type: ?NetworkMigrationCodeGenerationSegmentType = null,

    pub const json_field_names = .{
        .artifacts = "artifacts",
        .created_at = "createdAt",
        .job_id = "jobID",
        .logical_id = "logicalID",
        .mapper_segment_id = "mapperSegmentID",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .network_migration_execution_id = "networkMigrationExecutionID",
        .segment_id = "segmentID",
        .segment_type = "segmentType",
    };
};
