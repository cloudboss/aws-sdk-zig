/// List the DASH manifest configuration.
pub const ListDashManifestConfiguration = struct {
    /// A short string that's appended to the endpoint URL. The manifest name
    /// creates a unique path to this endpoint. If you don't enter a value,
    /// MediaPackage uses the default manifest name, index.
    manifest_name: []const u8,

    /// The egress domain URL for stream delivery from MediaPackage.
    url: ?[]const u8,

    pub const json_field_names = .{
        .manifest_name = "ManifestName",
        .url = "Url",
    };
};
