const IdNamespaceType = @import("id_namespace_type.zig").IdNamespaceType;

/// The input source of the ID mapping table.
pub const IdMappingTableInputSource = struct {
    /// The unique identifier of the ID namespace association.
    id_namespace_association_id: []const u8,

    /// The type of the input source of the ID mapping table.
    type: IdNamespaceType,

    pub const json_field_names = .{
        .id_namespace_association_id = "idNamespaceAssociationId",
        .type = "type",
    };
};
