const ArtifactType = @import("artifact_type.zig").ArtifactType;
const MavenReference = @import("maven_reference.zig").MavenReference;
const S3ContentLocation = @import("s3_content_location.zig").S3ContentLocation;

/// Specifies dependency JARs, as well as JAR files that contain user-defined
/// functions (UDF).
pub const CustomArtifactConfiguration = struct {
    /// `UDF` stands for user-defined functions. This type of artifact must be in an
    /// S3 bucket. A `DEPENDENCY_JAR` can be in either Maven or an S3 bucket.
    artifact_type: ArtifactType,

    /// The parameters required to fully specify a Maven reference.
    maven_reference: ?MavenReference = null,

    s3_content_location: ?S3ContentLocation = null,

    pub const json_field_names = .{
        .artifact_type = "ArtifactType",
        .maven_reference = "MavenReference",
        .s3_content_location = "S3ContentLocation",
    };
};
