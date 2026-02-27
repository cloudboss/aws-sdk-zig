/// Information about a harvested Low-Latency HLS manifest.
pub const HarvestedLowLatencyHlsManifest = struct {
    /// The name of the harvested Low-Latency HLS manifest.
    manifest_name: []const u8,

    pub const json_field_names = .{
        .manifest_name = "ManifestName",
    };
};
