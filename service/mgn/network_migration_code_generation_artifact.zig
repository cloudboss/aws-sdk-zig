const NetworkMigrationCodeGenerationArtifactSubType = @import("network_migration_code_generation_artifact_sub_type.zig").NetworkMigrationCodeGenerationArtifactSubType;
const NetworkMigrationCodeGenerationArtifactType = @import("network_migration_code_generation_artifact_type.zig").NetworkMigrationCodeGenerationArtifactType;
const Checksum = @import("checksum.zig").Checksum;
const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// An artifact generated during code generation, such as a CloudFormation
/// template or Terraform file.
pub const NetworkMigrationCodeGenerationArtifact = struct {
    /// The unique identifier of the artifact.
    artifact_id: ?[]const u8 = null,

    /// The sub-type of the artifact for further classification.
    artifact_sub_type: ?NetworkMigrationCodeGenerationArtifactSubType = null,

    /// The type of the artifact, such as CLOUDFORMATION_TEMPLATE or
    /// TERRAFORM_MODULE.
    artifact_type: ?NetworkMigrationCodeGenerationArtifactType = null,

    /// The checksum of the artifact for integrity verification.
    checksum: ?Checksum = null,

    /// The timestamp when the artifact was created.
    created_at: ?i64 = null,

    /// The logical identifier for the artifact.
    logical_id: ?[]const u8 = null,

    /// The S3 location where the artifact is stored.
    output_s3_configuration: ?S3Configuration = null,

    pub const json_field_names = .{
        .artifact_id = "artifactID",
        .artifact_sub_type = "artifactSubType",
        .artifact_type = "artifactType",
        .checksum = "checksum",
        .created_at = "createdAt",
        .logical_id = "logicalID",
        .output_s3_configuration = "outputS3Configuration",
    };
};
