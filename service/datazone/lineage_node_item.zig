const FormOutput = @import("form_output.zig").FormOutput;

/// The summary and output forms of a LineageNode
pub const LineageNodeItem = struct {
    /// The timestamp at which the data lineage node was created.
    created_at: ?i64 = null,

    /// The user who created the data lineage node.
    created_by: ?[]const u8 = null,

    /// The description of the data lineage node.
    description: ?[]const u8 = null,

    /// The ID of the domain of the data lineage node.
    domain_id: []const u8,

    /// The IDs of the downstream data lineage nodes.
    downstream_lineage_node_ids: ?[]const []const u8 = null,

    /// The event timestamp of the data lineage node.
    event_timestamp: ?i64 = null,

    /// The forms included in the additional attributes of a data lineage node.
    forms_output: ?[]const FormOutput = null,

    /// The ID of the data lineage node.
    id: []const u8,

    /// The name of the data lineage node.
    name: ?[]const u8 = null,

    /// The alternate ID of the data lineage node.
    source_identifier: ?[]const u8 = null,

    /// The name of the type of the data lineage node.
    type_name: []const u8,

    /// The type of the revision of the data lineage node.
    type_revision: ?[]const u8 = null,

    /// The timestamp at which the data lineage node was updated.
    updated_at: ?i64 = null,

    /// The user who updated the data lineage node.
    updated_by: ?[]const u8 = null,

    /// The IDs of the upstream data lineage nodes.
    upstream_lineage_node_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .downstream_lineage_node_ids = "downstreamLineageNodeIds",
        .event_timestamp = "eventTimestamp",
        .forms_output = "formsOutput",
        .id = "id",
        .name = "name",
        .source_identifier = "sourceIdentifier",
        .type_name = "typeName",
        .type_revision = "typeRevision",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .upstream_lineage_node_ids = "upstreamLineageNodeIds",
    };
};
