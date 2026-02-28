const ArtifactsType = @import("artifacts_type.zig").ArtifactsType;

/// Represents a resolved build artifact. A resolved artifact is an artifact
/// that is built and
/// deployed to the destination, such as Amazon S3.
pub const ResolvedArtifact = struct {
    /// The identifier of the artifact.
    identifier: ?[]const u8,

    /// The location of the artifact.
    location: ?[]const u8,

    /// Specifies the type of artifact.
    type: ?ArtifactsType,

    pub const json_field_names = .{
        .identifier = "identifier",
        .location = "location",
        .type = "type",
    };
};
