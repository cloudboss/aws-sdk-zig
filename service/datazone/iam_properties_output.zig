/// The IAM properties of a connection.
pub const IamPropertiesOutput = struct {
    /// The environment ID of the connection.
    environment_id: ?[]const u8,

    /// Specifies whether Amazon Web Services Glue lineage sync is enabled for a
    /// connection.
    glue_lineage_sync_enabled: ?bool,

    pub const json_field_names = .{
        .environment_id = "environmentId",
        .glue_lineage_sync_enabled = "glueLineageSyncEnabled",
    };
};
