/// The IAM properties patch of a connection.
pub const IamPropertiesPatch = struct {
    /// Specifies whether Amazon Web Services Glue lineage sync is enabled for a
    /// connection.
    glue_lineage_sync_enabled: ?bool,

    pub const json_field_names = .{
        .glue_lineage_sync_enabled = "glueLineageSyncEnabled",
    };
};
