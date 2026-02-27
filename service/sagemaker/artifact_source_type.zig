const ArtifactSourceIdType = @import("artifact_source_id_type.zig").ArtifactSourceIdType;

/// The ID and ID type of an artifact source.
pub const ArtifactSourceType = struct {
    /// The type of ID.
    source_id_type: ArtifactSourceIdType,

    /// The ID.
    value: []const u8,

    pub const json_field_names = .{
        .source_id_type = "SourceIdType",
        .value = "Value",
    };
};
