const IdNamespaceIdMappingWorkflowMetadata = @import("id_namespace_id_mapping_workflow_metadata.zig").IdNamespaceIdMappingWorkflowMetadata;
const IdNamespaceType = @import("id_namespace_type.zig").IdNamespaceType;

/// A summary of ID namespaces.
pub const IdNamespaceSummary = struct {
    /// The timestamp of when the ID namespace was created.
    created_at: i64,

    /// The description of the ID namespace.
    description: ?[]const u8 = null,

    /// An object which defines any additional configurations required by the ID
    /// mapping workflow.
    id_mapping_workflow_properties: ?[]const IdNamespaceIdMappingWorkflowMetadata = null,

    /// The Amazon Resource Name (ARN) of the ID namespace.
    id_namespace_arn: []const u8,

    /// The name of the ID namespace.
    id_namespace_name: []const u8,

    /// The type of ID namespace. There are two types: `SOURCE` and `TARGET`.
    ///
    /// The `SOURCE` contains configurations for `sourceId` data that will be
    /// processed in an ID mapping workflow.
    ///
    /// The `TARGET` contains a configuration of `targetId` which all `sourceIds`
    /// will resolve to.
    @"type": IdNamespaceType,

    /// The timestamp of when the ID namespace was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .id_mapping_workflow_properties = "idMappingWorkflowProperties",
        .id_namespace_arn = "idNamespaceArn",
        .id_namespace_name = "idNamespaceName",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
