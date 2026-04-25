/// The lakehouse properties of a connection.
pub const LakehousePropertiesInput = struct {
    /// Specifies whether to enable Glue lineage sync for tables managed by Glue
    /// crawlers.
    glue_lineage_sync_enabled: ?bool = null,

    pub const json_field_names = .{
        .glue_lineage_sync_enabled = "glueLineageSyncEnabled",
    };
};
