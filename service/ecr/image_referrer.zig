const aws = @import("aws");

const ArtifactStatus = @import("artifact_status.zig").ArtifactStatus;

/// An object representing an artifact associated with a subject image.
pub const ImageReferrer = struct {
    /// A map of annotations associated with the artifact.
    annotations: ?[]const aws.map.StringMapEntry,

    /// The status of the artifact. Valid values are `ACTIVE`, `ARCHIVED`, or
    /// `ACTIVATING`.
    artifact_status: ?ArtifactStatus,

    /// A string identifying the type of artifact.
    artifact_type: ?[]const u8,

    /// The digest of the artifact manifest.
    digest: []const u8,

    /// The media type of the artifact manifest.
    media_type: []const u8,

    /// The size, in bytes, of the artifact.
    size: i64,

    pub const json_field_names = .{
        .annotations = "annotations",
        .artifact_status = "artifactStatus",
        .artifact_type = "artifactType",
        .digest = "digest",
        .media_type = "mediaType",
        .size = "size",
    };
};
