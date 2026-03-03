/// The endpoint URL used to access an Asset using one PackagingConfiguration.
pub const EgressEndpoint = struct {
    /// The ID of the PackagingConfiguration being applied to the Asset.
    packaging_configuration_id: ?[]const u8 = null,

    /// The current processing status of the asset used for the packaging
    /// configuration. The status can be either QUEUED, PROCESSING, PLAYABLE, or
    /// FAILED. Status information won't be available for most assets ingested
    /// before 2021-09-30.
    status: ?[]const u8 = null,

    /// The URL of the parent manifest for the repackaged Asset.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .packaging_configuration_id = "PackagingConfigurationId",
        .status = "Status",
        .url = "Url",
    };
};
