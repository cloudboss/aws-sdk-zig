/// Contains the schema type properties for a configured table association.
pub const ConfiguredTableAssociationSchemaTypeProperties = struct {
    /// The unique identifier of the configured table association.
    configured_table_association_id: []const u8,

    pub const json_field_names = .{
        .configured_table_association_id = "configuredTableAssociationId",
    };
};
