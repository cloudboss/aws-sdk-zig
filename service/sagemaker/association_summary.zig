const AssociationEdgeType = @import("association_edge_type.zig").AssociationEdgeType;
const UserContext = @import("user_context.zig").UserContext;

/// Lists a summary of the properties of an association. An association is an
/// entity that links other lineage or experiment entities. An example would be
/// an association between a training job and a model.
pub const AssociationSummary = struct {
    /// The type of the association.
    association_type: ?AssociationEdgeType = null,

    created_by: ?UserContext = null,

    /// When the association was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the destination.
    destination_arn: ?[]const u8 = null,

    /// The name of the destination.
    destination_name: ?[]const u8 = null,

    /// The destination type.
    destination_type: ?[]const u8 = null,

    /// The ARN of the source.
    source_arn: ?[]const u8 = null,

    /// The name of the source.
    source_name: ?[]const u8 = null,

    /// The source type.
    source_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_type = "AssociationType",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .destination_arn = "DestinationArn",
        .destination_name = "DestinationName",
        .destination_type = "DestinationType",
        .source_arn = "SourceArn",
        .source_name = "SourceName",
        .source_type = "SourceType",
    };
};
