/// The lakehouse properties of a connection.
pub const LakehousePropertiesOutput = struct {
    /// Specifies whether Glue lineage sync is enabled for tables managed by Glue
    /// crawlers.
    glue_lineage_sync_enabled: ?bool = null,

    pub const json_field_names = .{
        .glue_lineage_sync_enabled = "glueLineageSyncEnabled",
    };
};
