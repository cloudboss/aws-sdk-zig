/// Summary information about a Microsoft Smooth Streaming (MSS) manifest
/// configuration. This provides key details about the MSS manifest without
/// including all configuration parameters.
pub const ListMssManifestConfiguration = struct {
    /// The name of the MSS manifest configuration.
    manifest_name: []const u8,

    /// The URL for accessing the MSS manifest.
    url: ?[]const u8,

    pub const json_field_names = .{
        .manifest_name = "ManifestName",
        .url = "Url",
    };
};
