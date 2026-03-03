const S3ArtifactLocation = @import("s3_artifact_location.zig").S3ArtifactLocation;
const ArtifactLocationType = @import("artifact_location_type.zig").ArtifactLocationType;

/// Represents information about the location of an artifact.
pub const ArtifactLocation = struct {
    /// The S3 bucket that contains the artifact.
    s_3_location: ?S3ArtifactLocation = null,

    /// The type of artifact in the location.
    @"type": ?ArtifactLocationType = null,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
        .@"type" = "type",
    };
};
