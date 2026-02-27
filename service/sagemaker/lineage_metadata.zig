const aws = @import("aws");

const AssociationInfo = @import("association_info.zig").AssociationInfo;

/// The metadata that tracks relationships between ML artifacts, actions, and
/// contexts.
pub const LineageMetadata = struct {
    /// The Amazon Resource Name (ARN) of the lineage action.
    action_arns: ?[]const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of the lineage artifact.
    artifact_arns: ?[]const aws.map.StringMapEntry,

    /// The lineage associations.
    associations: ?[]const AssociationInfo,

    /// The Amazon Resource Name (ARN) of the lineage context.
    context_arns: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .action_arns = "ActionArns",
        .artifact_arns = "ArtifactArns",
        .associations = "Associations",
        .context_arns = "ContextArns",
    };
};
