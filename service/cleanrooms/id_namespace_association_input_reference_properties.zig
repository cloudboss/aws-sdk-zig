const IdNamespaceType = @import("id_namespace_type.zig").IdNamespaceType;

/// Provides the information for the ID namespace association input reference
/// properties.
pub const IdNamespaceAssociationInputReferenceProperties = struct {
    /// Defines how ID mapping workflows are supported for this ID namespace
    /// association.
    id_mapping_workflows_supported: []const []const u8,

    /// The ID namespace type for this ID namespace association.
    id_namespace_type: IdNamespaceType,

    pub const json_field_names = .{
        .id_mapping_workflows_supported = "idMappingWorkflowsSupported",
        .id_namespace_type = "idNamespaceType",
    };
};
