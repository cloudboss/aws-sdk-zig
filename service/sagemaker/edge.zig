const AssociationEdgeType = @import("association_edge_type.zig").AssociationEdgeType;

/// A directed edge connecting two lineage entities.
pub const Edge = struct {
    /// The type of the Association(Edge) between the source and destination. For
    /// example `ContributedTo`, `Produced`, or `DerivedFrom`.
    association_type: ?AssociationEdgeType,

    /// The Amazon Resource Name (ARN) of the destination lineage entity of the
    /// directed edge.
    destination_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the source lineage entity of the directed
    /// edge.
    source_arn: ?[]const u8,

    pub const json_field_names = .{
        .association_type = "AssociationType",
        .destination_arn = "DestinationArn",
        .source_arn = "SourceArn",
    };
};
