const IdNamespaceType = @import("id_namespace_type.zig").IdNamespaceType;

/// Detailed information about the ID namespace association input reference
/// properties.
pub const IdNamespaceAssociationInputReferencePropertiesSummary = struct {
    /// The ID namespace type for this ID namespace association.
    id_namespace_type: IdNamespaceType,

    pub const json_field_names = .{
        .id_namespace_type = "idNamespaceType",
    };
};
