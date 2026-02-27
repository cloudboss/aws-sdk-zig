/// Information about a harvested DASH manifest.
pub const HarvestedDashManifest = struct {
    /// The name of the harvested DASH manifest.
    manifest_name: []const u8,

    pub const json_field_names = .{
        .manifest_name = "ManifestName",
    };
};
