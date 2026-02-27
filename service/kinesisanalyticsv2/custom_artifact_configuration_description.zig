const ArtifactType = @import("artifact_type.zig").ArtifactType;
const MavenReference = @import("maven_reference.zig").MavenReference;
const S3ContentLocation = @import("s3_content_location.zig").S3ContentLocation;

/// Specifies a dependency JAR or a JAR of user-defined functions.
pub const CustomArtifactConfigurationDescription = struct {
    /// `UDF` stands for user-defined functions. This type of artifact must be in an
    /// S3 bucket. A `DEPENDENCY_JAR` can be in either Maven or an S3 bucket.
    artifact_type: ?ArtifactType,

    /// The parameters that are required to specify a Maven dependency.
    maven_reference_description: ?MavenReference,

    s3_content_location_description: ?S3ContentLocation,

    pub const json_field_names = .{
        .artifact_type = "ArtifactType",
        .maven_reference_description = "MavenReferenceDescription",
        .s3_content_location_description = "S3ContentLocationDescription",
    };
};
