/// Information about a harvested HLS manifest.
pub const HarvestedHlsManifest = struct {
    /// The name of the harvested HLS manifest.
    manifest_name: []const u8,

    pub const json_field_names = .{
        .manifest_name = "ManifestName",
    };
};
