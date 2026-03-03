/// The Aurora DB cluster storage configuration used for recommendations.
pub const AuroraDbClusterStorageConfiguration = struct {
    /// The storage type to associate with the Aurora DB cluster.
    storage_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .storage_type = "storageType",
    };
};
