/// List the HTTP live streaming (HLS) manifest configuration.
pub const ListHlsManifestConfiguration = struct {
    /// A short string that's appended to the endpoint URL. The child manifest name
    /// creates a unique path to this endpoint. If you don't enter a value,
    /// MediaPackage uses the default child manifest name, index_1. The manifestName
    /// on the HLSManifest object overrides the manifestName you provided on the
    /// originEndpoint object.
    child_manifest_name: ?[]const u8 = null,

    /// A short short string that's appended to the endpoint URL. The manifest name
    /// creates a unique path to this endpoint. If you don't enter a value,
    /// MediaPackage uses the default manifest name, index. MediaPackage
    /// automatically inserts the format extension, such as .m3u8. You can't use the
    /// same manifest name if you use HLS manifest and low-latency HLS manifest. The
    /// manifestName on the HLSManifest object overrides the manifestName you
    /// provided on the originEndpoint object.
    manifest_name: []const u8,

    /// The egress domain URL for stream delivery from MediaPackage.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .child_manifest_name = "ChildManifestName",
        .manifest_name = "ManifestName",
        .url = "Url",
    };
};
