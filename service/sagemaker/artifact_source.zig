const ArtifactSourceType = @import("artifact_source_type.zig").ArtifactSourceType;

/// A structure describing the source of an artifact.
pub const ArtifactSource = struct {
    /// A list of source types.
    source_types: ?[]const ArtifactSourceType,

    /// The URI of the source.
    source_uri: []const u8,

    pub const json_field_names = .{
        .source_types = "SourceTypes",
        .source_uri = "SourceUri",
    };
};
