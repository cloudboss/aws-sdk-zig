/// The summary of the data lineage node.
pub const LineageNodeSummary = struct {
    /// The timestamp at which the data lineage node was created.
    created_at: ?i64 = null,

    /// The user who created the data lineage node.
    created_by: ?[]const u8 = null,

    /// The description of the data lineage node.
    description: ?[]const u8 = null,

    /// The ID of the domain of the data lineage node.
    domain_id: []const u8,

    /// The event timestamp of the data lineage node.
    event_timestamp: ?i64 = null,

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

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .event_timestamp = "eventTimestamp",
        .id = "id",
        .name = "name",
        .source_identifier = "sourceIdentifier",
        .type_name = "typeName",
        .type_revision = "typeRevision",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
